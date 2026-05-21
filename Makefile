include .env
export

env-up:
	@docker compose up -d ecommerce-postgres

env-down:
	@docker compose down ecommerce-postgres

env-cleanup:
	@docker compose down ecommerce-postgres && \
	rm -rf out/pgdata && \
	echo "Files deleted";

env-port-forward:
	@docker compose up -d port-forwarder

env-port-close:
	@docker compose down -d port-forwarder

migrate-create:
	@if [ -z "$(name)" ]; then \
  		echo "Missing parameter 'name='"; \
  		exit 1; \
	fi; \
	MSYS_NO_PATHCONV=1 docker compose run --rm ecommerce-postgres-migrate \
		create \
		-ext sql \
		-dir /migrations \
		-seq $(name)

migrate-up:
	@make migrate-action action=up

migrate-down:
	@make migrate-action action=down

migrate-action:
	@if [ -z "$(name)" ]; then \
		echo "Missing parameter 'action='"; \
		exit 1; \
	fi; \
	MSYS_NO_PATHCONV=1 docker compose run --rm ecommerce-postgres-migrate \
		-path /migrations \
		-database postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@ecommerce-postgres:5432/${POSTGRES_DB}?sslmode=disable \
		$(action)

