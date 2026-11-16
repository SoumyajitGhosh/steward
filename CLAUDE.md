# Steward: working notes for Claude

Autonomous IT service agent on Azure (Entra ID + GitHub tools, policy engine, durable Service Bus executor,
verifier, pgvector memory, CI evals). Source of truth: the "Steward: Autonomous IT Service Agent on Azure — Build Guide"
(13 steps). This file is the short version; update it whenever a decision or convention changes.

## Git workflow
- `main` holds the project setup only (layout, build skeleton, local stack, tooling, docs). Do not develop on it.
- `development` is the working branch, created from `main`. Step work is committed there.
- Conventional commits (`type(scope): subject`), enforced by `.githooks/commit-msg`; run `make hooks` once per clone.
- Never create a PR unless asked. Never commit secrets (`.env`, `infra/local/secrets/`).

## Layout
- `steward-common` shared: LLM gateway, tool contracts, problem details, idempotency. No Spring Web.
- `steward-api` Spring Boot: tickets, runs, approvals, SSE, transactional outbox to Service Bus.
- `steward-worker` Spring Boot: planner, policy, executor, verifier, tools, memory. Scales to zero.
- `steward-portal` React 19 + Vite + MSAL. `evals/` Python harness. `infra/` Bicep, local compose, scripts.
- `policy/rules.yaml` policy rules; `knowledge/` runbooks the planner retrieves; `openapi/steward.yaml` API contract.
- Java package root: `com.steward.{common,api,worker}`.

## Local ports
api 8080, worker actuator 8081, portal 5173, Postgres 5432, Service Bus AMQP 5672 / health 5300, Prometheus 9090, Grafana 3000.

## Commands
- `make up` / `make down` local stack (needs `infra/local/.env`, copy from `.env.example`)
- `make sb-health`, `make deploy-infra ENV=dev`, `make seed-tenant`
- `./mvnw verify` build and test all modules

## Standards (apply to every step)
IaC only (Bicep) after step 2; no secrets in code/config/CI; least privilege (API identity has no Graph perms);
contract-first API; Flyway migrations; RFC 9457 errors with traceId; exactly-once via outbox + idempotency keys;
the model is untrusted (validate plans, args, results); every write tool has precheck, verify and compensation;
kill switch and budgets; tests for behaviour; ADRs in `docs/adr/` (the user writes these).

## Status
- [x] Step 1 setup: layout, Maven multi-module, compose + Service Bus emulator, Bicep skeleton (on `main`)
- [ ] Step 2 onward: on `development`

## Conventions for this repo
- The user types/owns the ADRs; do not write them unless asked.
- Skills for repeatable workflows live in `.claude/skills/`; add or update one when a workflow repeats.
