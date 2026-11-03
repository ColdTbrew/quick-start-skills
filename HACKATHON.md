# 3시간 해커톤 웹앱 — Codex 실행 카드

> **외울 한 문장:** "ColdTbrew/quick-start-skills의 HACKATHON.md 읽고 그대로 해. 3000 포트 하나, 로그인·SQLite·CRUD 필수, Taste Skill로 UI 마무리. 과제: [문제]"

이 문서는 **해커톤에서 웹앱 제작을 요구받을 때** 적용한다. 데이터 분석만 요구하는 과제라면 기존 `task-workflow` 등 데이터 과제 스킬을 우선한다.

## Codex가 가장 먼저 할 일

1. 이 문서와 [상세 설계서](docs/webapp-3000.md), [webapp-3000 스킬](skills/webapp-3000/SKILL.md)을 읽는다.
2. 필요한 경우 아래 한 줄로 quick-start 스킬과 외부 Taste 디자인 스킬을 설치한다. **npm 설치 가능**, GitHub 접근 가능.
3. 과제의 요구사항을 파악하고 즉시 3000 포트에서 화면을 띄운 뒤 로그인·로컬 DB·핵심 CRUD를 구현한다.
4. **UI는 기능이 실제로 작동한 다음** Taste Skill을 적용하여 빠르게 다듬는다.
5. 실제 접속·가입/로그인·CRUD·재시작·권한 분리·빌드를 검증한다.

```bash
git clone --depth 1 https://github.com/ColdTbrew/quick-start-skills /tmp/quick-start-skills &&
bash /tmp/quick-start-skills/install.sh --with-taste
```

## 절대 제약

- **외부 노출 3000 포트 하나만 허용** (웹 + 로그인 API + CRUD API 모두 같은 앱).
- **브라우저는 시험 데모 URL만 열 수 있음.** GitHub와 패키지/문서 접근은 Codex CLI/터미널로 처리. 다른 웹페이지를 열라고 요구하지 않는다.
- **npm 설치 가능**. 브라우저 접근 불가와 npm 불가를 혼동하지 않는다.
- **앱 런타임은 외부 서비스 미사용**: Clerk, Neon, Supabase, Firebase, 외부 SSO/OAuth, 원격 DB, CDN, AI 챗봇 등 금지.
- 권장: **TanStack Start + React + TypeScript + shadcn/ui + Tailwind + Better Auth(email/password) + SQLite + Drizzle + Zod**.
- DB는 별도 포트를 열지 않는 `./data/app.sqlite` 파일. 가입/로그인/로그아웃과 사용자별 CRUD를 실제로 작동시킨다.
- 비밀번호는 안전하게 해시하고 인증 쿠키·권한을 서버에서 검증한다. secrets/DB 파일은 git에 커밋하지 않는다.
- 미완성 화면·가짜 데이터 성공 표시·작동하지 않는 버튼을 "완료"라고 보고하지 않는다.

## 시험장 첫 프롬프트 (그대로 복사)

```text
GitHub의 ColdTbrew/quick-start-skills/HACKATHON.md와 연결된 webapp-3000 스킬을 CLI로 읽고 그대로 실행해.
npm 사용 가능, 브라우저는 데모 URL만 열 수 있어. 웹/API/로그인은 3000 포트 하나만 사용해.
로컬 이메일 로그인 + SQLite + 사용자별 CRUD 필수, SSO·외부 서비스·AI 챗봇 불필요.
먼저 실제 동작하는 MVP를 만들고, Taste Skill은 UI 마무리에 사용해.
설치, 서버 실행, 기능 구현, 최종 검증까지 수행해.
과제: [여기에 실제 과제 붙여넣기]
```

**GitHub CLI 접근 대안:** `curl -fsSL https://raw.githubusercontent.com/ColdTbrew/quick-start-skills/main/HACKATHON.md`

관련 파일:
- [웹앱 기술 구성·검증 계획](docs/webapp-3000.md)
- [Codex용 웹앱 전문 스킬](skills/webapp-3000/SKILL.md)
- [짧은 프롬프트](prompts/02-webapp-3000.md)

> 대회에서 Codex/GitHub, 기존 스킬/사전 코드 사용이 허용되는지 현장 안내를 우선 확인한다.
