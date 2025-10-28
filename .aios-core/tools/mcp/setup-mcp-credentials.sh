#!/bin/bash
# MCP Credentials Setup Helper
# This script helps configure MCP server credentials for Claude Desktop

set -e

CONFIG_FILE="$HOME/Library/Application Support/Claude/claude_desktop_config.json"
ENV_FILE="${1:-.env}"

echo "🔧 MCP Credentials Setup Helper"
echo "================================"
echo ""

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ Claude Desktop config not found at: $CONFIG_FILE"
    echo "   Please ensure Claude Desktop is installed."
    exit 1
fi

echo "✅ Found Claude Desktop config"
echo ""

# Function to update PostgreSQL connection string
update_postgres() {
    echo "📊 PostgreSQL Configuration"
    echo "----------------------------"

    if [ -f "$ENV_FILE" ]; then
        # Try to extract Supabase URL
        SUPABASE_URL=$(grep -E "^SUPABASE_DB_URL=" "$ENV_FILE" | cut -d'=' -f2- | tr -d '"' | tr -d "'")

        if [ -n "$SUPABASE_URL" ]; then
            echo "Found SUPABASE_DB_URL in $ENV_FILE"
            echo "Would you like to use this for PostgreSQL MCP? (y/n)"
            read -r response

            if [ "$response" = "y" ]; then
                # Use jq to update the config
                if command -v jq &> /dev/null; then
                    jq ".mcpServers.postgres.args[3] = \"$SUPABASE_URL\" | .mcpServers.postgres.disabled = false" "$CONFIG_FILE" > "${CONFIG_FILE}.tmp"
                    mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"
                    echo "✅ PostgreSQL MCP configured and enabled"
                else
                    echo "⚠️  jq not found. Please manually update the postgres connection string in:"
                    echo "   $CONFIG_FILE"
                    echo "   Connection string: $SUPABASE_URL"
                fi
            fi
        else
            echo "⚠️  SUPABASE_DB_URL not found in $ENV_FILE"
            echo "   Please add your PostgreSQL connection string manually to:"
            echo "   $CONFIG_FILE"
        fi
    else
        echo "⚠️  .env file not found at: $ENV_FILE"
        echo "   Please add your PostgreSQL connection string manually to:"
        echo "   $CONFIG_FILE"
    fi
    echo ""
}

# Function to update GitHub token
update_github() {
    echo "🐙 GitHub Configuration"
    echo "-----------------------"

    # Try to get token from gh CLI
    if command -v gh &> /dev/null; then
        if gh auth status &> /dev/null; then
            GH_TOKEN=$(gh auth token 2>/dev/null || echo "")

            if [ -n "$GH_TOKEN" ]; then
                echo "Found GitHub token from gh CLI"
                echo "Would you like to use this for GitHub MCP? (y/n)"
                read -r response

                if [ "$response" = "y" ]; then
                    if command -v jq &> /dev/null; then
                        jq ".mcpServers.github.env.GITHUB_PERSONAL_ACCESS_TOKEN = \"$GH_TOKEN\" | .mcpServers.github.disabled = false" "$CONFIG_FILE" > "${CONFIG_FILE}.tmp"
                        mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"
                        echo "✅ GitHub MCP configured and enabled"
                    else
                        echo "⚠️  jq not found. Please manually update the GitHub token in:"
                        echo "   $CONFIG_FILE"
                    fi
                fi
            fi
        else
            echo "⚠️  gh CLI not authenticated. Run: gh auth login"
        fi
    else
        echo "⚠️  gh CLI not found. Please install it or add a GitHub token manually."
    fi
    echo ""
}

# Function to prompt for Brave API key
update_brave() {
    echo "🔍 Brave Search Configuration"
    echo "------------------------------"
    echo "Do you have a Brave Search API key? (y/n)"
    read -r response

    if [ "$response" = "y" ]; then
        echo "Enter your Brave API key:"
        read -r -s BRAVE_KEY

        if [ -n "$BRAVE_KEY" ]; then
            if command -v jq &> /dev/null; then
                jq ".mcpServers[\"brave-search\"].env.BRAVE_API_KEY = \"$BRAVE_KEY\" | .mcpServers[\"brave-search\"].disabled = false" "$CONFIG_FILE" > "${CONFIG_FILE}.tmp"
                mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"
                echo "✅ Brave Search MCP configured and enabled"
            else
                echo "⚠️  jq not found. Please manually update the Brave API key in:"
                echo "   $CONFIG_FILE"
            fi
        fi
    else
        echo "ℹ️  Get a Brave Search API key at: https://brave.com/search/api/"
    fi
    echo ""
}

# Main setup flow
echo "This script will help you configure MCP servers that require credentials."
echo ""

# Check for jq
if ! command -v jq &> /dev/null; then
    echo "⚠️  Warning: jq is not installed. Some automatic updates may not work."
    echo "   Install jq with: brew install jq"
    echo ""
fi

# Run configuration steps
update_postgres
update_github
update_brave

echo "✨ Setup complete!"
echo ""
echo "📝 Active MCP Servers:"
echo "   ✅ Supabase (OAuth) - https://mcp.supabase.com/mcp"
echo "   ✅ Filesystem - Project directory access"
echo "   ✅ SQLite - MMOS database access"
echo "   ✅ Git - Repository operations"
echo ""
echo "🔄 Restart Claude Desktop to apply changes."
echo ""
echo "📖 To manually edit configuration:"
echo "   open '$CONFIG_FILE'"
