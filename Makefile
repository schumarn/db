
# # Makefile
# 
# Makefile define tasks you can do with the db/
# project you've just cloned.

PG_FOLDER = ./pg
PG_DB_OPTS = -D $(PG_FOLDER)
PG_LOG_OPTS = -l $(PG_FOLDER)/postgres.log

REDIS_FOLDER = ./redis
REDIS_OPTS = ./redis.conf

GROC_OPTS = --whitespace-after-token true

DB_NAME = test


default: doc
	@echo open doc/Makefile.html to view \
		list of available tasks.

# ### make doc
# 
# Generates the document file (you're probably
# reading it)
doc:
	groc Makefile $(GROC_OPTS)

# ### make clean
# 
# Cleans all files and reset the whole repository
# to mint condition.
# 
# **WARNING:** Also erases all data in all
# database.
clean:
	git clean -xdf .


# # POSTGRESQL TASKS

# ### make pg-init
# 
# Creates and initializes a ./pg directory with
# files required to for a standard PostgreSQL
# installation to run.
pg-init:
	mkdir -p $(PG_FOLDER)
	initdb $(PG_DB_OPTS)

# ### make pg-run
# 
# Runs a PostgreSQL instance in the current
# terminal window using the ./pg folder as the
# data directory. Terminates with CTRL-C.
pg-run:
	postgres $(PG_DB_OPTS)

# ### make pg-start
# 
# Starts a PostgreSQL instance as a background
# service using the ./pg folder as the data
# directory. Terminates with pg-stop task.
pg-start:
	pg_ctl start $(PG_DB_OPTS) $(PG_LOG_OPTS)

# ### make pg-stop
# 
# Stops the PostgreSQL background service ran
# with the task `pg-start`
pg-stop:
	pg_ctl stop $(PG_DB_OPTS) $(PG_LOG_OPTS)


# # REDIS TASKS

# ### make redis-init
# 
# Creates a redis/ folder to store redis database
# files.
redis-init:
	mkdir -p $(REDIS_FOLDER)

# ### make redis-run
# 
# Starts a Redis server instance in the current
# terminal window. Terminates with CTRL-C or
# `redis-stop` from another terminal.
redis-run:
	redis-server $(REDIS_OPTS)

# ### make redis-start
# 
# Starts a Redis server instance as a background
# service. Terminates with `redis-stop` or sends
# the redis command `SHUTDOWN`.
redis-start:
	redis-server $(REDIS_OPTS) &

# ### make redis-stop
# 
# Stops any Redis instance listening on the
# default port by sending a `SHUTDOWN` command.
redis-stop:
	redis-cli SHUTDOWN


.PHONY: default doc pg-* redis-*

