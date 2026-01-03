# Arquitetura: Mini-Apps Trilha 1

## Documento de Arquitetura Técnica

**Versão:** 1.0
**Data:** 2025-01-03
**Autor:** Aria (Architect Agent)
**Input:** specs-mini-apps.md (Course Architect)

---

## 1. Validação da Stack

### 1.1 Stack Sugerida vs Recomendada

| Camada | Sugerido | Recomendação | Justificativa |
|--------|----------|--------------|---------------|
| Framework | Next.js | **Next.js 14 (App Router)** | SSG para apps estáticos, export estático para self-hosting |
| Styling | Tailwind | **Tailwind CSS v3** | ✅ Aprovado - utility-first, tree-shakeable |
| UI Components | shadcn/ui | **shadcn/ui** | ✅ Aprovado - copy-paste, não dependência |
| State | Zustand | **Zustand + Immer** | ✅ Aprovado + Immer para mutações imutáveis |
| Persistence | localStorage | **localStorage + IndexedDB fallback** | IndexedDB para dados maiores (>5MB) |
| Export PDF | react-pdf | **@react-pdf/renderer** | Melhor controle de layout |
| Export JSON/MD | - | **file-saver + jszip** | Download de múltiplos arquivos |
| Forms | - | **react-hook-form + zod** | Validação type-safe |
| Icons | - | **lucide-react** | Tree-shakeable, consistente com shadcn |
| Deploy | Vercel | **Vercel + Static Export** | Deploy grátis, CDN global |

### 1.2 Decisões Arquiteturais Chave

#### Por que Next.js 14 com Static Export?

```javascript
// next.config.js
const nextConfig = {
  output: 'export',  // Gera HTML/CSS/JS estáticos
  images: {
    unoptimized: true  // Necessário para static export
  },
  trailingSlash: true  // Melhor compatibilidade com hosting estático
}
```

**Benefícios:**
- Build gera pasta `out/` com arquivos estáticos
- Hospedável em qualquer servidor (Nginx, Apache, S3, GitHub Pages)
- Zero dependência de Node.js em produção
- Aluno pode fazer `npx serve out/` localmente

#### Por que Zustand + localStorage?

```typescript
// stores/useStore.ts
import { create } from 'zustand'
import { persist } from 'zustand/middleware'
import { immer } from 'zustand/middleware/immer'

interface AppState {
  empresa: string
  funcoes: Funcao[]
  setEmpresa: (empresa: string) => void
  addFuncao: (funcao: Funcao) => void
}

export const useStore = create<AppState>()(
  persist(
    immer((set) => ({
      empresa: '',
      funcoes: [],
      setEmpresa: (empresa) => set({ empresa }),
      addFuncao: (funcao) => set((state) => {
        state.funcoes.push(funcao)
      })
    })),
    {
      name: 'mapa-dependencia-v1',  // key no localStorage
      version: 1,
      migrate: (persisted, version) => {
        // Migrations para versões futuras
        return persisted
      }
    }
  )
)
```

**Benefícios:**
- Auto-save a cada mudança
- Migrations de schema built-in
- Offline-first por padrão
- State compartilhado entre componentes

---

## 2. Estrutura do Monorepo

### 2.1 Arquitetura Turborepo

```
academia-tools/
├── .github/
│   └── workflows/
│       └── deploy.yml           # CI/CD para Vercel
├── apps/
│   ├── mapa-dependencia/        # Mini-App 1
│   ├── matriz-decisao/          # Mini-App 2
│   ├── sop-inteligente/         # Mini-App 3
│   ├── delegacao-assistida/     # Mini-App 4
│   └── roi-pessoas/             # Mini-App 5
├── packages/
│   ├── ui/                      # Componentes compartilhados (shadcn)
│   ├── core/                    # Lógica de negócio compartilhada
│   ├── export/                  # PDF, JSON, Markdown exports
│   ├── ai-prompts/              # Geração de prompts para IA
│   ├── eslint-config/           # ESLint compartilhado
│   └── tsconfig/                # TypeScript configs compartilhados
├── turbo.json
├── package.json
└── README.md
```

### 2.2 Estrutura de Cada App

```
apps/mapa-dependencia/
├── src/
│   ├── app/
│   │   ├── layout.tsx          # Layout raiz
│   │   ├── page.tsx            # Página inicial (redirect)
│   │   ├── empresa/
│   │   │   └── page.tsx        # Tela 1: Info empresa
│   │   ├── funcoes/
│   │   │   └── page.tsx        # Tela 2: Mapeamento
│   │   ├── riscos/
│   │   │   └── page.tsx        # Tela 3: Análise
│   │   ├── plano/
│   │   │   └── page.tsx        # Tela 4: Plano de ação
│   │   └── export/
│   │       └── page.tsx        # Tela de export
│   ├── components/
│   │   ├── forms/              # Formulários específicos
│   │   ├── tables/             # Tabelas específicas
│   │   └── charts/             # Gráficos específicos
│   ├── stores/
│   │   └── useMapaDependencia.ts
│   ├── lib/
│   │   ├── calculations.ts     # Lógica de cálculo
│   │   └── prompts.ts          # Geração de prompts
│   └── types/
│       └── index.ts            # Types do app
├── public/
│   └── og-image.png            # OpenGraph
├── next.config.js
├── package.json
├── tailwind.config.js
└── README.md                   # Doc específica do app
```

### 2.3 Package: UI Compartilhado

```
packages/ui/
├── src/
│   ├── components/
│   │   ├── Button.tsx
│   │   ├── Input.tsx
│   │   ├── Select.tsx
│   │   ├── Table.tsx
│   │   ├── Card.tsx
│   │   ├── Badge.tsx
│   │   ├── Alert.tsx
│   │   ├── Dialog.tsx
│   │   ├── Progress.tsx
│   │   └── Stepper.tsx         # Wizard navigation
│   ├── layout/
│   │   ├── AppShell.tsx        # Layout padrão
│   │   ├── Header.tsx
│   │   └── Footer.tsx
│   └── index.ts
├── package.json
└── tailwind.config.js
```

### 2.4 Package: Core (Lógica de Negócio)

```
packages/core/
├── src/
│   ├── calculations/
│   │   ├── risco.ts            # calcularCustoRisco, sugerirRisco
│   │   ├── automacao.ts        # calcularScoreAutomacao
│   │   ├── roi.ts              # calcularCustoCLT, calcularROI
│   │   └── sop.ts              # calcularTempoTotal, validarSOP
│   ├── validators/
│   │   └── schemas.ts          # Zod schemas compartilhados
│   ├── formatters/
│   │   ├── currency.ts         # formatCurrency, parseCurrency
│   │   └── date.ts
│   └── index.ts
└── package.json
```

### 2.5 Package: Export

```
packages/export/
├── src/
│   ├── pdf/
│   │   ├── templates/
│   │   │   ├── MapaDependenciaPDF.tsx
│   │   │   ├── MatrizDecisaoPDF.tsx
│   │   │   └── ...
│   │   └── generator.ts
│   ├── json/
│   │   └── exporter.ts
│   ├── markdown/
│   │   └── exporter.ts
│   └── index.ts
└── package.json
```

### 2.6 Package: AI Prompts

```
packages/ai-prompts/
├── src/
│   ├── generators/
│   │   ├── validacao.ts        # Prompts de validação
│   │   ├── assistencia.ts      # Prompts de assistência
│   │   ├── automacao.ts        # Prompts para criar regras
│   │   └── analise.ts          # Prompts de análise
│   ├── templates/
│   │   └── base.ts             # Template base dos prompts
│   ├── clipboard.ts            # copyToClipboard helper
│   └── index.ts
└── package.json
```

---

## 3. Estratégia de Deploy

### 3.1 Deploy Principal: Vercel

```yaml
# .github/workflows/deploy.yml
name: Deploy to Vercel

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Node
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Build all apps
        run: npm run build

      - name: Deploy Mapa Dependencia
        uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_MAPA }}
          working-directory: apps/mapa-dependencia
```

### 3.2 URLs de Produção

| App | URL Sugerida |
|-----|--------------|
| Mapa Dependência | mapa-dependencia.academialendaria.com.br |
| Matriz Decisão | matriz-decisao.academialendaria.com.br |
| SOP Inteligente | sop.academialendaria.com.br |
| Delegação Assistida | delegacao.academialendaria.com.br |
| ROI Pessoas | roi-pessoas.academialendaria.com.br |

**Alternativa single-domain:**
- tools.academialendaria.com.br/mapa-dependencia
- tools.academialendaria.com.br/matriz-decisao
- etc.

### 3.3 Self-Hosting pelo Aluno

#### Opção 1: Download do Build

```bash
# Na página do app, botão "Download para Self-Host"
# Baixa: mapa-dependencia-v1.0.zip contendo:
#   - out/           (build estático)
#   - README.md      (instruções)
#   - docker-compose.yml (opcional)
```

#### Opção 2: Fork do Repositório

```markdown
## Como fazer fork

1. Fork este repositório
2. Clone: `git clone https://github.com/SEU_USER/academia-tools`
3. Instale: `npm install`
4. Rode local: `npm run dev --filter=mapa-dependencia`
5. Build: `npm run build --filter=mapa-dependencia`
6. Deploy: `npx serve apps/mapa-dependencia/out`
```

#### Opção 3: Docker

```dockerfile
# Dockerfile (em cada app)
FROM nginx:alpine
COPY out/ /usr/share/nginx/html
EXPOSE 80
```

```yaml
# docker-compose.yml
version: '3.8'
services:
  mapa-dependencia:
    build: ./apps/mapa-dependencia
    ports:
      - "3001:80"
  matriz-decisao:
    build: ./apps/matriz-decisao
    ports:
      - "3002:80"
  # ... outros apps
```

---

## 4. Padrões de Código para Forkabilidade

### 4.1 Configuração Zero

```typescript
// config/index.ts
export const config = {
  // Tudo funciona sem estas configs
  supabase: {
    enabled: false,  // Opcional
    url: process.env.NEXT_PUBLIC_SUPABASE_URL || '',
    anonKey: process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || ''
  },
  analytics: {
    enabled: false,  // Opcional
    gtmId: process.env.NEXT_PUBLIC_GTM_ID || ''
  },
  branding: {
    name: process.env.NEXT_PUBLIC_APP_NAME || 'Mapa de Dependência',
    logo: process.env.NEXT_PUBLIC_LOGO_URL || '/logo.svg',
    primaryColor: process.env.NEXT_PUBLIC_PRIMARY_COLOR || '#6366f1'
  }
}
```

### 4.2 Persistência Híbrida

```typescript
// lib/storage.ts
import { config } from '@/config'
import { supabase } from '@/lib/supabase'

export async function saveData<T>(key: string, data: T): Promise<void> {
  // Sempre salva local primeiro
  localStorage.setItem(key, JSON.stringify(data))

  // Se Supabase configurado E usuário logado, sincroniza
  if (config.supabase.enabled) {
    const { data: user } = await supabase.auth.getUser()
    if (user) {
      await supabase
        .from('user_data')
        .upsert({ user_id: user.id, key, data })
    }
  }
}

export async function loadData<T>(key: string): Promise<T | null> {
  // Tenta local primeiro
  const local = localStorage.getItem(key)
  if (local) return JSON.parse(local)

  // Se Supabase configurado, tenta remoto
  if (config.supabase.enabled) {
    const { data: user } = await supabase.auth.getUser()
    if (user) {
      const { data } = await supabase
        .from('user_data')
        .select('data')
        .eq('user_id', user.id)
        .eq('key', key)
        .single()
      return data?.data || null
    }
  }

  return null
}
```

### 4.3 Estrutura de Componentes

```typescript
// components/FuncaoForm.tsx
import { useForm } from 'react-hook-form'
import { zodResolver } from '@hookform/resolvers/zod'
import { z } from 'zod'
import { Button, Input, Select } from '@academia/ui'

// Schema exportado para reuso
export const funcaoSchema = z.object({
  cargo: z.string().min(1).max(50),
  pessoa: z.string().min(1).max(50),
  impacto: z.string().min(1).max(200),
  horas_semana: z.number().min(1).max(80),
  documentado: z.enum(['Sim', 'Nao', 'Parcial']),
  backup: z.boolean(),
  risco: z.enum(['Alto', 'Medio', 'Baixo'])
})

export type FuncaoInput = z.infer<typeof funcaoSchema>

interface Props {
  onSubmit: (data: FuncaoInput) => void
  defaultValues?: Partial<FuncaoInput>
}

export function FuncaoForm({ onSubmit, defaultValues }: Props) {
  const { register, handleSubmit, formState: { errors } } = useForm<FuncaoInput>({
    resolver: zodResolver(funcaoSchema),
    defaultValues
  })

  return (
    <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
      <Input
        label="Cargo/Função"
        {...register('cargo')}
        error={errors.cargo?.message}
      />
      {/* ... outros campos */}
      <Button type="submit">Adicionar</Button>
    </form>
  )
}
```

### 4.4 Export Pattern

```typescript
// lib/export.ts
import { pdf } from '@react-pdf/renderer'
import { saveAs } from 'file-saver'
import { MapaDependenciaPDF } from '@academia/export'

export async function exportPDF(data: MapaDependenciaData, filename: string) {
  const blob = await pdf(<MapaDependenciaPDF data={data} />).toBlob()
  saveAs(blob, `${filename}.pdf`)
}

export function exportJSON(data: unknown, filename: string) {
  const blob = new Blob([JSON.stringify(data, null, 2)], {
    type: 'application/json'
  })
  saveAs(blob, `${filename}.json`)
}

export function exportMarkdown(content: string, filename: string) {
  const blob = new Blob([content], { type: 'text/markdown' })
  saveAs(blob, `${filename}.md`)
}
```

### 4.5 AI Prompt Pattern

```typescript
// lib/ai-prompt.ts
export function copyPromptToClipboard(prompt: string): Promise<void> {
  return navigator.clipboard.writeText(prompt)
}

export function openInChatGPT(prompt: string) {
  const encoded = encodeURIComponent(prompt)
  window.open(`https://chat.openai.com/?q=${encoded}`, '_blank')
}

export function openInClaude(prompt: string) {
  const encoded = encodeURIComponent(prompt)
  window.open(`https://claude.ai/new?q=${encoded}`, '_blank')
}

// Componente de UI
export function AIPromptButton({ prompt, label = 'Validar com IA' }) {
  const [copied, setCopied] = useState(false)

  const handleCopy = async () => {
    await copyPromptToClipboard(prompt)
    setCopied(true)
    setTimeout(() => setCopied(false), 2000)
  }

  return (
    <div className="flex gap-2">
      <Button onClick={handleCopy}>
        {copied ? 'Copiado!' : label}
      </Button>
      <DropdownMenu>
        <DropdownMenuItem onClick={() => openInChatGPT(prompt)}>
          Abrir no ChatGPT
        </DropdownMenuItem>
        <DropdownMenuItem onClick={() => openInClaude(prompt)}>
          Abrir no Claude
        </DropdownMenuItem>
      </DropdownMenu>
    </div>
  )
}
```

---

## 5. Dependências do Projeto

### 5.1 Root package.json

```json
{
  "name": "academia-tools",
  "private": true,
  "workspaces": ["apps/*", "packages/*"],
  "scripts": {
    "dev": "turbo dev",
    "build": "turbo build",
    "lint": "turbo lint",
    "type-check": "turbo type-check"
  },
  "devDependencies": {
    "turbo": "^2.0.0",
    "typescript": "^5.3.0"
  }
}
```

### 5.2 App Dependencies

```json
{
  "dependencies": {
    "next": "14.1.0",
    "react": "18.2.0",
    "react-dom": "18.2.0",
    "zustand": "^4.5.0",
    "immer": "^10.0.0",
    "react-hook-form": "^7.50.0",
    "@hookform/resolvers": "^3.3.0",
    "zod": "^3.22.0",
    "@react-pdf/renderer": "^3.3.0",
    "file-saver": "^2.0.5",
    "lucide-react": "^0.330.0",
    "@academia/ui": "workspace:*",
    "@academia/core": "workspace:*",
    "@academia/export": "workspace:*",
    "@academia/ai-prompts": "workspace:*"
  },
  "devDependencies": {
    "tailwindcss": "^3.4.0",
    "autoprefixer": "^10.4.0",
    "postcss": "^8.4.0",
    "@types/react": "^18.2.0",
    "@types/file-saver": "^2.0.7"
  }
}
```

---

## 6. Próximos Passos

### Para @dev (implementação)

1. **Setup inicial**
   ```bash
   npx create-turbo@latest academia-tools
   cd academia-tools
   ```

2. **Criar packages compartilhados** (ordem)
   - `packages/tsconfig`
   - `packages/eslint-config`
   - `packages/ui` (shadcn components)
   - `packages/core` (business logic)
   - `packages/export` (PDF, JSON, MD)
   - `packages/ai-prompts`

3. **Criar primeiro app** (MVP)
   - `apps/mapa-dependencia`
   - Implementar todas 6 telas
   - Testar exports
   - Validar offline-first

4. **Replicar para outros apps**
   - Seguir padrão estabelecido
   - Reusar packages

### Estimativa de Complexidade

| Item | Esforço |
|------|---------|
| Setup Turborepo | 2h |
| Package UI (shadcn) | 4h |
| Package Core | 4h |
| Package Export | 4h |
| Package AI-Prompts | 2h |
| App Mapa Dependência | 8h |
| App Matriz Decisão | 4h |
| App SOP Inteligente | 6h |
| App Delegação Assistida | 8h |
| App ROI Pessoas | 8h |
| Deploy Setup | 2h |
| **TOTAL** | **~52h** |

---

## Decisões Arquiteturais (ADRs)

### ADR-001: Monorepo com Turborepo
- **Decisão:** Usar Turborepo para monorepo
- **Motivo:** Cache de builds, paralelização, dependency management
- **Alternativas rejeitadas:** Repos separados (mais complexo para manter), Nx (overhead desnecessário)

### ADR-002: Static Export
- **Decisão:** Usar `output: 'export'` do Next.js
- **Motivo:** Requisito de self-hosting sem Node.js
- **Trade-offs:** Sem SSR, sem API routes (não necessários)

### ADR-003: Zustand para State
- **Decisão:** Zustand + persist + immer
- **Motivo:** Simples, persist built-in, tree-shakeable
- **Alternativas rejeitadas:** Redux (verbose), Jotai (menos familiar)

### ADR-004: shadcn/ui
- **Decisão:** Usar shadcn/ui como base de componentes
- **Motivo:** Copy-paste (não dependência), customizável, Radix-based
- **Trade-offs:** Setup inicial, mas total controle

---

**Documento gerado por:** Aria (Architect Agent)
**Data:** 2025-01-03
**Versão:** 1.0

— Aria, arquitetando o futuro 🏗️
