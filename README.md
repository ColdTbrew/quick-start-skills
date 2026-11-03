# quick-start-skills

Small, generic, process-oriented agent skills for a timed practical AI/data task where a stakeholder holds requirements the README leaves out. Written for Codex (Agent Skills format: `skills/<name>/SKILL.md`), and they work in any agent that reads that format.

They contain no task-specific code or answers. They describe *how to work*: what to ask, what to check, how to evaluate honestly, when to stop adding, and how to keep a decision trail you can explain later.

| Skill | What it is for |
|---|---|
| `task-workflow` | Order of work and time budget for a 180-minute task |
| `requirements-elicitation` | Questions to ask the stakeholder before modeling |
| `data-audit` | Leakage, duplicates, time order, missing values, imbalance, drift |
| `honest-eval` | Deployment-like split, metric at the operating constraint, baseline first, explain the number |
| `minimal-solution` | Simplest approach that meets the constraints; no overengineering |
| `verify-before-submit` | Run the real artifact; pre-submit checklist |
| `report-writer` | 1–2 page decision-oriented report |
| `decision-log` | Append-only `DECISIONS.md` and prep for no-AI follow-up questions |
| `webapp-3000` | **3-hour full-stack demo:** TanStack Start, local login, SQLite/CRUD, single port 3000, Taste design pass |

## Install

```bash
git clone --depth 1 https://github.com/ColdTbrew/quick-start-skills /tmp/quick-start-skills && bash /tmp/quick-start-skills/install.sh
```

- Default target is `~/.agents/skills` (Codex user scope), so the skills stay out of the task workspace.
- `--project` installs into `./.agents/skills` instead.
- `--with-pstack` also copies six pstack principle skills from `backnotprop/pstack`.
- `--with-taste` installs **the official `design-taste-frontend`** skill from `Leonxlnx/taste-skill` for Codex via npm (`npx skills`). Node.js 22.20+ is recommended/required by the current skills CLI.
- Check in Codex with `/skills`, or call one directly with `$task-workflow`.

`AGENTS.md` is a short working agreement. Copy it into the workspace only if you want Codex to load it automatically.


## 3-hour hackathon webapp (Codex CLI)

Read **[HACKATHON.md](HACKATHON.md)** for the one-line prompt and **[docs/webapp-3000.md](docs/webapp-3000.md)** for full architecture and checklists. The [`webapp-3000`](skills/webapp-3000/SKILL.md) skill is installed with all other quick-start skills.

Exam constraints: browser access is limited to the **demo app URL**, but **Codex CLI can use GitHub and npm**. Only **port 3000** is accessible; frontend, APIs and email/password login share the same server. Use local **SQLite** + Drizzle, **Better Auth** for local authentication, and no SSO, remote DB, external SaaS, or AI chatbot.

```bash
git clone --depth 1 https://github.com/ColdTbrew/quick-start-skills /tmp/quick-start-skills
bash /tmp/quick-start-skills/install.sh --with-taste
# Restart Codex if the new skills do not show up in /skills
```

For Codex, the **Taste Skill** comes from [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill), installed independently rather than vendored into this repository. Run Taste **only after the working login + DB + CRUD demo**, spending roughly 10–15 minutes on visual polish instead of its full multi-step design workflow. Browse/test only the allowed demo URL; avoid remote fonts and photos.

Quick prompt:

> **ColdTbrew/quick-start-skills의 HACKATHON.md 읽고 따라. 3000포트, 로컬 로그인·SQLite·CRUD, Taste로 UI 마무리. 과제: [문제]**

See [`prompts/02-webapp-3000.md`](prompts/02-webapp-3000.md) for a ready-to-paste longer version.

## Credits

Several skills restate ideas from [pstack](https://github.com/cursor/plugins/tree/main/pstack) by Lauren Tan (MIT; standalone mirror at [backnotprop/pstack](https://github.com/backnotprop/pstack)), in particular *prove-it-works*, *explain-the-number*, *fix-root-causes*, *laziness-protocol*, *subtract-before-you-add*, *in-your-own-words* and *show-me-your-work*. The wording here is original and adapted to data tasks. See `NOTICE`.

## License

MIT. See `LICENSE`.


## Prompts

- [`prompts/01-recon.md`](prompts/01-recon.md): 모델 만들기 전 정찰용 Codex 프롬프트 (데이터 점검 → 담당자 질문 → 임시 계획).
