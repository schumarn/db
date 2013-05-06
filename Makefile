
# # Makefile
# 
# Makefile define tasks you can do with the db/
# project you've just cloned.

PG_FOLDER = ./pg
PG_DB_OPTS = -D $(PG_FOLDER)
PG_LOG_OPTS = -l $(PG_FOLDER)/postgres.log

REDIS_FOLDER = ./redis
REDIS_OPTS = ./redis/redis.conf

GROC_OPTS = --whitespace-after-token true --github -i Makefile -o ./doc
GROC_FILES = Makefile


default: doc
	@echo open doc/Makefile.html to view \
		list of available tasks.

# ### make doc

# Generates the document file (you're probably
# reading it)
doc:
	groc $(GROC_OPTS) $(GROC_FILES)

# ### make clean

# Cleans all files and reset the whole repository
# to mint condition.
# 
# **WARNING:** Also erases all data in all
# database.
clean:
	git clean -xdf .


# # POSTGRESQL TASKS

# ### make pg-init

# Creates and initializes a ./pg directory with
# files required to for a standard PostgreSQL
# installation to run.
pg-init:
	mkdir -p $(PG_FOLDER)
	initdb $(PG_DB_OPTS)

# ### make pg-run

# Runs a PostgreSQL instance in the current
# terminal window using the ./pg folder as the
# data directory. Terminates with CTRL-C.
pg-run:
	postgres $(PG_DB_OPTS)

# ### make pg

# Starts a PostgreSQL instance as a background
# service using the ./pg folder as the data
# directory. Terminates with pg-stop task.
pg:
	pg_ctl start $(PG_DB_OPTS) $(PG_LOG_OPTS)

# ### make pg-stop

# Stops the PostgreSQL background service ran
# with the task `pg-start`
pg-stop:
	pg_ctl stop $(PG_DB_OPTS) $(PG_LOG_OPTS)


# # REDIS TASKS

# ### make redis-run

# Starts a Redis server instance in the current
# terminal window. Terminates with CTRL-C or
# `redis-stop` from another terminal.
redis-run:
	redis-server $(REDIS_OPTS)

# ### make redis

# Starts a Redis server instance as a background
# service. Terminates with `redis-stop` or sends
# the redis command `SHUTDOWN`.
redis:
	redis-server $(REDIS_OPTS) &

# ### make redis-stop

# Stops any Redis instance listening on the
# default port by sending a `SHUTDOWN` command.
redis-stop:
	redis-cli SHUTDOWN


# # MAILCATCHER TASKS

# ### make mc-run

# Runs an instance of Mailcatcher using the
# configured options as a foreground process
# in the current terminal.
# Terminates with CTRL-C.
mc-run:
	mailcatcher --foreground

# ### make mc  
# ### make mailcatcher

# Runs an instance of Mailcatcher using the
# configured options as a background process.
# Terminate with `mc-stop`
mailcatcher: | mc
mc:
	mailcatcher

# ### make mc-stop

# Stops an instance of Mailcatcher running
# as a background process.
mc-stop:
	curl -v -X DELETE http://0.0.0.0:1080


.PHONY: default doc pg pg-* redis redis-* mc mc-*

