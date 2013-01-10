
# db/ folder

If you are like me and you hate running a lot of services, particularly
databases in the background that silently consumes your machine resources
without your consent, then you might find this project useful.

This project is a right now, just a simple Makefile with pre-configured
command line calls so you can start and stop several common services at once
with ease via `make` and can be sure that all data created by those services
is contained inside the folder which means they can be cleaned by simply running
`git-clean`.

Right now it only runs a few services that I needed. I will add more
in the future as I needs them or if someone sends me a pull request :)

### INITIALIZE

You needs to run this command once for each service that requires initializing
and also if you have just ran `git-clean` for the service.

```sh
$ make pg-init redis-init
```

### START

For example, to start PostgreSQL, Redis and Mailcatcher all at once, just run:

```sh
$ make pg-start redis-start mc-start
```

### STOP

Stopping services is just as easy:

```sh
$ make pg-stop redis-stop mc-stop
```

### CLEAN

To clean all data from services, just run `git clean -xdf` on any related folder.

For example, to completely wipe your PostgreSQL clean and start fresh, just do this:

```sh
$ git clean -xdf pg/
```

If you are not sure what files `git` will delete from your system, just run a
what-if mode once and `git-clean` will print out files that it would delete:

```sh
$ git clean -xdn pg/
```

# LICENSE

WTFPL (http://www.wtfpl.net/txt/copying/)

# SUPPORT / CONTRIBUTE

Just ping me [@chakrit](http://twitter.com/chakrit) on Twitter or
[open a new GitHub issue](https://github.com/chakrit/db/issues/new)

PRs also accepted.

