# 3000 포트 단일 서버 해커톤 웹앱 아키텍처

## 1. 현장 환경

- 데모를 완성해야 하는 제한 시간: **180분**.
- 브라우저는 **데모 웹앱 URL**에만 접속 가능하다. GitHub·문서·OAuth 설정을 위해 다른 사이트를 브라우저로 열 수 없다.
- Codex CLI에서 GitHub에 접근할 수 있다. **npm 패키지 설치도 가능**하다.
- 외부에서 접속 가능한 포트는 **3000 하나뿐**이다. 별도 API 서버나 DB 외부 포트를 열지 않는다.
- 목표는 **회원가입/로그인 + 로컬 DB 영속 저장 + 실제 CRUD + 과제별 핵심 기능 + 대시보드**. AI 챗봇, SSO, 외부 SaaS 필요 없다.

```text
[사용자 브라우저: 허용된 데모 URL / :3000]
                 |
      [TanStack Start 단일 서버]
       |         |           |
 [React UI] [Better Auth] [Server Functions/Routes]
                 |           |
              [SQLite 로컬 파일]
                via Drizzle / better-sqlite3
```

**권장:** TanStack Start · React · TypeScript · shadcn/ui · Tailwind CSS · Better Auth(email+password만) · SQLite · better-sqlite3 · Drizzle ORM · Zod.

- 로그인: `/api/auth/*`를 **동일한 3000 포트**에 연결. OAuth/SSO/외부 인증 서비스 없이 가입/로그인/로그아웃 구현.
- 데이터: 같은 SQLite `./data/app.sqlite`에 인증 테이블과 업무 데이터를 저장. 별도 PostgreSQL/Redis/서버 없음.
- 비즈니스 로직: TanStack Start Server Functions 혹은 동일 origin Server Routes.
- 보안: Better Auth의 암호 해싱/세션 쿠키를 쓰고 **서버의 각 CRUD에서 user ID로 소유권 검증**. 클라이언트가 전달한 userId는 권한 근거로 신뢰하지 않는다.
- 저장: `data/`, `.env*`, `*.db`, `*.sqlite*`는 gitignore. 재시작 테스트는 하되 **컨테이너 삭제 등 작업공간 소멸 후 보존은 별도 환경 정책에 달림**.
- 실제 데모 도메인이 localhost가 아니면 Better Auth baseURL, trusted origin, cookie 설정을 실제 호스트/프록시에 맞춘다.
- 온라인 웹폰트/CDN/외부 이미지 없이도 UI가 표시되도록 로컬 assets, 시스템 폰트, npm 패키지를 활용한다.

## 2. Codex/터미널 설치 절차

0. 기존 프로젝트·의존성을 먼저 조사. 준비된 코드가 있으면 불필요하게 재초기화하지 않는다.
1. 처음부터 새 앱이어야 하면 shadcn의 TanStack Start 템플릿으로 스캐폴딩:

```bash
npx shadcn@latest init -t start
# 생성된 디렉터리로 이동 후
npm install better-auth drizzle-orm better-sqlite3 zod
npm install -D drizzle-kit @types/better-sqlite3
```

2. 템플릿이 CLI 버전과 맞지 않으면 공식 CLI `npx @tanstack/cli@latest create`로 Start 앱을 만들고 shadcn을 추가한다. 설치 여부는 실행 출력으로 확인.
3. Better Auth 공식 TanStack Start 통합 가이드 기준으로 `/api/auth/*`, DB adapter, SQLite schema를 연결하고 필요한 마이그레이션 적용. `BETTER_AUTH_SECRET`은 로컬에서 안전하게 생성하여 비공개 환경변수에 저장.
4. 3000 포트를 고정하고 외부 접속할 수 있는 인터페이스에 바인딩:

```bash
npm run dev -- --host 0.0.0.0 --port 3000 --strictPort
```

실제 템플릿의 `package.json`에 맞게 수정 가능. **포트 3000 외에는 사용하지 않는다.** 실제 시험장에 제공된 데모 URL로 확인.

5. 터미널에서 응답 확인(필요시):

```bash
curl -I http://127.0.0.1:3000/
```

6. 실제 과제에 필요한 테이블, 입력 폼, 결과 화면, CRUD를 구현한 뒤 빌드까지 실행.

**공식 참고:** [TanStack Start](https://tanstack.com/start/latest/docs/framework/react/overview) · [shadcn TanStack 설치](https://ui.shadcn.com/docs/installation/tanstack) · [Better Auth TanStack 통합](https://www.better-auth.com/docs/integrations/tanstack) · [Drizzle SQLite](https://orm.drizzle.team/docs/get-started/sqlite-new)

## 3. Codex 스킬 설치

```bash
git clone --depth 1 https://github.com/ColdTbrew/quick-start-skills /tmp/quick-start-skills
bash /tmp/quick-start-skills/install.sh --with-taste
```

- 기존 quick-start 스킬을 유지하면서 `webapp-3000`도 설치.
- `--with-taste`는 제3자 스킬 소스를 복사/재배포하는 대신 **공식 리포지토리에서** `design-taste-frontend`를 Codex에 설치한다.
- Taste 원본: `Leonxlnx/taste-skill`. 독립 설치 명령: `npx skills add Leonxlnx/taste-skill --skill design-taste-frontend -a codex -g -y`.
- Taste는 UI 화면의 레이아웃·타이포·간격·디자인 완성도를 위한 스킬. **앱 핵심 기능 구현 전 Taste의 전체 브라우저 검증/레퍼런스 이미지 탐색을 돌리면 시간을 소모**할 수 있다.
- 브라우저 검증은 **허용된 데모 URL만** 활용한다. 스킬이 외부 이미지/웹사이트 접근을 요구하면 해당 부분 생략하고 로컬 자산만 사용.
- 앱 MVP 완성 후 Taste 사용 시간은 기본 **10–15분**으로 제한. 전체 30–45분 디자인 리빌드가 아니라 기존 컴포넌트 개선에 집중한다.

## 4. 180분 일정

| 경과 | 작업 | 완료 기준 |
|---|---|---|
| 0–15분 | 과제·제약 파악, 서버 스캐폴딩 | 브라우저에서 :3000 UI 확인 |
| 15–45분 | Better Auth + 로컬 SQLite | 가입/로그인/로그아웃 실제 동작 |
| 45–110분 | 데이터 모델 + 과제 핵심 CRUD | DB에 실제 저장 및 조회 |
| 110–145분 | 실제 과제 워크플로우 완성 | 입력 → 처리 → 결과 |
| 145–165분 | 디자인 및 안정화 | Taste로 UI 일부 개선, 오류 처리 |
| 165–180분 | 검증·제출 | 재실행·권한·빌드·시연 |

**막히면:** 디자인/부가기능을 즉시 중단하고 동작하는 최소 시나리오를 확보. SSO, 원격 DB, 별도 백엔드, 불필요한 테스트 프레임워크는 추가하지 않는다.

## 5. 검증 체크리스트

- [ ] 앱/UI/API/인증 모두 **3000 포트 하나** 사용. 별도 노출 포트 없음.
- [ ] 브라우저는 허용된 데모 URL 외 접근하지 않음. 기본 기능에 외부 서비스 요청 없음.
- [ ] 실제 사용자 가입 → 로그인 → 새로고침 → 로그아웃 정상.
- [ ] 실제 SQLite에 레코드 생성·조회·수정·삭제.
- [ ] 서버 재시작 후 데이터 보존.
- [ ] 다른 사용자는 내 데이터 조회/수정 불가.
- [ ] 로그인 없이 보호 기능 접근 차단.
- [ ] 비밀번호 평문 저장 금지, secret/DB 파일 커밋 금지.
- [ ] 대회 핵심 시나리오 실행. 테스트용 가짜 성공 화면을 실제 기능으로 보고하지 않음.
- [ ] TypeScript/프로덕션 빌드 성공. 실패 시 원인과 남은 작업 명시.
