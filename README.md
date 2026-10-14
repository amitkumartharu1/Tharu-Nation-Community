# Tharu Nation Community

A cultural-heritage website, community platform and admin studio on **Cloudflare Workers + D1 + R2**.
Vanilla HTML/CSS/JS (no framework, no build step), English + Nepali, built to preserve Tharu history,
language, traditions, photographs, videos and oral histories with consent and credit.

| Resource | Name |
|---|---|
| Worker | `tharu-nation-community` |
| D1 database | `tharu-nation-db` |
| R2 bucket | `tharu-nation-media` |
| Live URL | https://tharu-nation-community.tharuamitkumar5.workers.dev |

> **Before deploying to production read [docs/DEPLOYMENT.md](docs/DEPLOYMENT.md).** Production's D1 is two migrations
> behind this code and the admin login mechanism changed. The order of steps matters.

## What is in it

**Public site** (`/`): Home · About · Explore Culture (13 sections + articles) · Cultural Stories · Photo Gallery
(filters, detail pages with description/credit/context, prev/next) · Video Gallery (uploaded files and external links, listed separately) ·
Festivals & Events (upcoming / ongoing / past computed from real dates, time-zone aware) · Community Contributions
(event, correction, resource, translation — always moderated; stories, photos and videos are shared by registered members) · Research & Resources ·
Oral Histories (consent-gated) · Cultural Map (privacy-reduced coordinates) · Search · Contact · Privacy · Terms ·
English/Nepali switch · `sitemap.xml`, `robots.txt`, social-preview tags.

**Membership** (`/join`, `/member`, `/verify/<ID>`, `/community-guidelines`): free member registration with admin approval, digital ID card with QR verification, Share Your Culture (photos / video / links, reviewed before publication), member notifications and appeals. Admin → Membership manages it all.

**Admin Studio** (`/admin`): Dashboard · Analytics · QR & NFC links · Articles & Stories (editor, preview, gallery,
translations) · Culture sections · Events · Categories · Research & Resources · Cultural Map · Oral Histories ·
Photo Gallery manager · Video manager (resumable uploads to R2 + external links) · Moderation (submissions, comments,
reports, translations) · Messages · Website Settings · Security & Audit (accounts/roles, sessions, password, activity log, storage maintenance).

## Project layout

```
src/            Worker (ES modules)
  index.js        entry: /api, /media, SPA fallback + social previews, sitemap, cron
  router.js       route table, auth/role/CSRF pipeline
  media-delivery.js   R2 streaming with Range support + visibility rules
  lib/            http, auth, crypto, rate limit, analytics, settings, validation, file sniffing, video URL parsing
  routes/         auth, public, admin-content, admin-media, admin-community, admin-system
public/         static assets served by Workers Assets
  index.html + js/ (SPA)   admin.html + js/admin/   css/   vendor/ (Leaflet, qrcode-generator)   _headers
migrations/     0001 baseline (= production schema) … 0008
tests/          unit + integration (+ optional large-upload) tests
docs/           deployment, architecture, security, test report, limits, changes
legacy/         previous version of the code, kept for reference only (not deployed)
```

## Local development

Requires Node 20+. Wrangler is installed with `npm install`.

```bash
npm install
cp .dev.vars.example .dev.vars        # then edit the two values
npm run dev                            # applies migrations to a LOCAL D1, starts http://localhost:8787
```

Open `/` for the public site and `/admin` to sign in. On a fresh local database the first sign-in with username `admin`
(`ADMIN_USERNAME` in `wrangler.toml`) and your `ADMIN_PASSWORD` creates the administrator.

## Tests

```bash
npm test               # unit + integration + membership tests (98) (spawns a throw-away local Worker, D1 and R2)
npm run test:large     # optional: 80 MB multipart video upload
npm run check          # syntax check + `wrangler deploy --dry-run`
```

Tests never touch production. See [docs/TEST_REPORT.md](docs/TEST_REPORT.md) for what was and was not verified.

## Configuration

Secrets (never in files that are committed):

```bash
npx wrangler secret put SESSION_SECRET      # ≥32 random characters
npx wrangler secret put ADMIN_PASSWORD      # bootstrap only; see docs/SECURITY.md
```

Optional variable `PBKDF2_ITERATIONS` (10 000–100 000, default 100 000) if sign-in fails with Cloudflare error 1102 on the
Workers **Free** plan (10 ms CPU limit). `ADMIN_USERNAME` is a plain variable in `wrangler.toml`.

## Free-tier limits (verified against Cloudflare docs, Oct 2026 — recheck before relying)

| Service | Free limit | Where it matters here |
|---|---|---|
| Workers | 100 000 requests/day, **10 ms CPU/request**, 100 MB request body | static assets are not counted; API + media requests are. Admin sign-in uses ~30 ms of CPU for PBKDF2 → may need `PBKDF2_ITERATIONS` or a paid plan |
| D1 | 5 M rows read/day, 100 k rows written/day, 5 GB | analytics writes ≈ 1 row per unique visitor/page/day |
| R2 | 10 GB-month storage, 1 M Class A / 10 M Class B ops per month, no egress fees via Workers | every photo/video byte served goes through the Worker (counts as requests) |

Upload limits: photos 15 MB, videos 500 MB, audio 200 MB, PDFs 50 MB, public photo submissions 10 MB (code constants in `src/lib/sniff.js`).
Large files use 8 MiB multipart parts, so no request body ever approaches the 100 MB limit.

More: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) · [docs/SECURITY.md](docs/SECURITY.md) · [docs/DEPLOYMENT.md](docs/DEPLOYMENT.md) ·
[docs/CHANGES.md](docs/CHANGES.md) (changed files, known limitations) · [docs/CREDITS.md](docs/CREDITS.md)
