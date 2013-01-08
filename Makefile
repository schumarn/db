
PG_DB_OPTS = -D ./pg
PG_LOG_OPTS = -l db/postgres.log
PG_OPTS = $(PG_DB_OPTS) $(PG_LOG_OPTS)

DB_NAME = test

pg-start:
	postgres $(PG_OPTS)
pg-create:
	createdb "$(DB_NAME)"

.PHONY: pg-*

