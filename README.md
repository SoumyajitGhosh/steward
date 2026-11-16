# Steward

Steward is a production-style autonomous agent for IT service requests. It turns a
plain-language request into a plan, executes the plan step by step against Microsoft
Entra ID and GitHub through typed, idempotent, dry-run-capable tools, and verifies
the outcome with independent reads before closing the ticket. A declarative policy
engine decides which steps run unattended and which wait for an approver; a
durable executor on Azure Service Bus persists every step so runs survive crashes
and multi-hour approval waits; episodic memory of past resolutions improves plans
over time. The whole system runs on Azure ContainerApps with managed identity,
Key Vault and Bicep, inside the free grants, and a nightly eval suite on a sandbox
tenant reports resolution rate, action precision, blocked unsafe attempts, cost and
time per ticket.

## Features

| # | Feature | What it does | What you learn |
|---|---------|--------------|----------------|
| 1 | Intake with clarification | Portal or API submits a request; the agent asks one targeted question when the request is ambiguous, then proceeds | Deciding when an agent should ask versus act |
| 2 | Planner | Produces a structured plan: steps, tools, arguments, preconditions, risk, how each step will be verified; grounded in runbooks and past resolutions | Structured outputs, plan schemas, grounding a planner |
| 3 | Policy engine | YAML rules decide per step: auto, approval by manager, approval by IT admin, or forbidden; blast-radius and separation-of-duties checks | Guardrails as code, testable policy |
| 4 | Durable executor | Service Bus worker executes steps, persists state after each, observes results, replans on failure (bounded), parks for approvals, compensates on abort, recovers from crashes | Durable workflows, idempotency, leases, outbox pattern |
| 5 | Typed tools over real systems | Microsoft Graph (users, groups, password reset, manager lookup), GitHub (repo access), Azure Resource Manager (resource groups) with managed identity; every tool has dry-run, idempotency and a verify read | Tool design for agents, least-privilege cloud identity |
| 6 | Verifier and closer | A separate model call checks evidence from fresh reads; writes the resolution note; escalates with a handoff pack when unsure | Independent verification, escalation design |
| 7 | Memory and feedback | pgvector over resolved runs supplies few-shot plans; requester feedback and reopen rates feed back into planning | Episodic memory, learning without fine-tuning |
| 8 | Evals in CI | Scenario tickets against a seeded sandbox tenant: resolution rate, action precision, 100% blocked unsafe attempts, steps, cost, time | Agent evals, sandboxing, release gates |
