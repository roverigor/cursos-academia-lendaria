-- ==============================================
-- v0.9.0 — Agent Scans Platform (KISS Version)
-- One table, JSONB everything, start simple
-- ==============================================

BEGIN;

-- Core table
CREATE TABLE agent_scans (
  id BIGSERIAL PRIMARY KEY,

  -- Identity
  agent_name TEXT NOT NULL,
  scan_number INTEGER NOT NULL,
  artifact_name TEXT NOT NULL,

  -- All scan data (flexible JSONB)
  data JSONB NOT NULL DEFAULT '{}'::jsonb,

  -- Metadata
  created_at TIMESTAMPTZ DEFAULT NOW(),

  -- Constraints
  UNIQUE(agent_name, scan_number)
);

-- Essential indexes only
CREATE INDEX idx_scans_agent ON agent_scans(agent_name);
CREATE INDEX idx_scans_created ON agent_scans(created_at DESC);
CREATE INDEX idx_scans_data_gin ON agent_scans USING GIN(data);

-- Comments
COMMENT ON TABLE agent_scans IS 'Multi-agent scan platform for analyzing artifacts (design, copy, schemas). JSONB-first for flexibility.';
COMMENT ON COLUMN agent_scans.data IS 'All analysis data in JSONB: {colors, frameworks, headlines, components, etc.}';

-- Helper function to get next scan number
CREATE OR REPLACE FUNCTION get_next_scan_number(p_agent_name TEXT)
RETURNS INTEGER AS $$
  SELECT COALESCE(MAX(scan_number), 0) + 1
  FROM agent_scans
  WHERE agent_name = p_agent_name;
$$ LANGUAGE sql;

COMMIT;
