COMPOSE = docker compose -f infra/local/docker-compose.yml --env-file infra/local/.env
ENV ?= dev
LOCATION ?= centralindia

.PHONY: up down sb-health deploy-infra seed-tenant hooks
up:            ; $(COMPOSE) up -d
down:          ; $(COMPOSE) down
sb-health:     ; curl -fsS localhost:5300/health
deploy-infra:  ; az deployment sub create --location $(LOCATION) --template-file infra/bicep/main.bicep --parameters env=$(ENV)
seed-tenant:   ; python infra/scripts/seed-tenant.py   # step 2
hooks:         ; git config core.hooksPath .githooks
