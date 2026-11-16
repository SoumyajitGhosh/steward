---
name: steward-build-step
description: Implement a numbered step from the Steward build guide on the `development` branch. Use when asked to "do step N", continue the build, or add a feature that belongs to a guide step.
---

# Build a Steward guide step

1. Confirm you are on `development` (never `main`); `git pull` first.
2. Re-read the step's Why/Build/Checkpoint/Tests/Commit in the guide and the "Production standards" table in `CLAUDE.md`.
3. Build in the order the guide gives. Keep code small, with comments saying what each part is for.
4. Prove it: run the Checkpoint items that can run here (`./mvnw verify`, `docker compose config`, `bicep build`
   if available, `pytest evals/`); say plainly which checks need the user's Azure account or Docker daemon.
5. Commit with the guide's conventional-commit message for the step; push to `development`.
6. Update the Status checklist in `CLAUDE.md`. Leave ADRs and Azure portal/app-registration actions to the user,
   and list them at the end of the reply.
