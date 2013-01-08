
PG_FOLDER = ./pg
PG_DB_OPTS = -D $(PG_FOLDER)
PG_LOG_OPTS = -l db/postgres.log
PG_OPTS = $(PG_DB_OPTS) $(PG_LOG_OPTS)

DB_NAME = test

pg-init:
	mkdir -p $(PG_FOLDER)
	initdb $(PG_DB_OPTS)
pg-start:
	postgres $(PG_OPTS)
pg-create:
	createdb "$(DB_NAME)"

.PHONY: pg-*

