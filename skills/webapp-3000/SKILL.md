---
name: webapp-3000
description: Use when a timed hackathon requires a working full-stack web application in 3 hours, with only port 3000 accessible, offline-at-runtime email/password login, SQLite persistence, CRUD, and a polished UI. Calls out CLI-only GitHub/npm setup and late-stage Taste Skill styling. Not for a model-only or report-only task.
---

# Webapp 3000 — 3-hour hackathon skill

Read `https://raw.githubusercontent.com/ColdTbrew/quick-start-skills/main/HACKATHON.md` and the linked `docs/webapp-3000.md` with CLI if available. If repository is cloned, read those files locally. Prefer task statement over generic defaults for the actual business feature.

## Non-negotiable constraints

- The browser may open **only the hackathon demo URL**. Use CLI for GitHub and npm; do not ask the human to open docs or external sign-in pages.
- **npm access works**. Use it to install dependencies.
- Only port **3000** is externally exposed, hosting frontend + backend + auth on the same origin.
- Full-stack app with **email/password registration, login, logout, SQLite persistence, user-scoped CRUD**. No Google login, SSO, external auth/DB, LLM chatbot, CDN, separate API/database service, or microservices.
- Stack: TanStack Start, React, TypeScript, shadcn/ui, Tailwind, Better Auth, Drizzle, better-sqlite3, Zod. Reuse a starter when compatible.
- DB secrets/private credentials are server-only; enforce auth and ownership on **every** DB operation.

## Execution

1. Read task and summarize the one scenario the judge must be able to demo. Clarify only blockers; proceed with explicit assumptions.
2. Bootstrap using `npx shadcn@latest init -t start`, or the official TanStack CLI if the current shadcn command is incompatible. Use npm to install `better-auth drizzle-orm better-sqlite3 zod` and dev tools `drizzle-kit @types/better-sqlite3`.
3. Implement Better Auth with local email/password on `/api/auth/*`, same SQLite DB as application CRUD, `BETTER_AUTH_SECRET` as a private environment variable. Configure auth URL to the actual demo origin, not hardcoded localhost when remote preview is used.
4. Listen on `0.0.0.0:3000`; adapt `npm run dev -- --host 0.0.0.0 --port 3000 --strictPort` to the actual project scripts.
5. Implement user-scoped database tables + minimal create/read/update/delete screens + task-specific core use case. Add form validation, real empty/loading/error states.
6. **Only once functionality works:** use the installed `design-taste-frontend` skill for 10–15 minutes of UI polish. Avoid full 30–45 minute multi-step Taste workflows, external imagery, and external browser sites. Browser checks only on the allowed demo URL.
7. Validate working :3000 route; registration/login/logout; CRUD; DB survives process restart; user B cannot access user A; typecheck/build; submitted demo scenario. Report concrete evidence and limitations.

## Skill selection

- `$webapp-3000` is primary for this explicit full-stack demo, **not** `$task-workflow` (model/data stakeholder workflow) unless the actual assignment is also a data task.
- `$minimal-solution`: remove nonessential features and dependencies.
- `$verify-before-submit`: prove the runnable artifact.
- `$decision-log`: record important choices only.
- `$design-taste-frontend`: cosmetic/UI quality pass after functional MVP; do not let it redesign already-working workflows.

Never mistake successful build or a screenshot for completed login and persisted CRUD. Test the actual behaviors.
