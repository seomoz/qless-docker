# Qless Docker

This repository gives the ability to create a docker container which
runs the [Qless](https://github.com/seomoz/qless) API (or the Qless web app).

# Build instructions

## Prerequisites

* [Docker](http://docs.docker.com/engine/installation/)

## Build steps

1. `docker build -t <name of image> .`

The built image has a directory at `/qless` which contains the qless web
application.

# How do I run the container?

When you want to run the container, you'll need to pass two environment
variables to `docker run ...` to successfully start the container:

1. `REDIS_HOST`: The host which is running the redis instance you want
   to connect to. E.g. `www.example.com`
2. `REDIS_PORT`: The port on the host which is running redis. E.g.
   `6379`.
3. `HTTP_PATH`: The path that the web app will be listening on. If not found,  `HTTP_PREFIX` will be used E.g.
   `/qless`
4. `REDIS_DB`: The redis DB number that the app will connect to.  Defaults
   to 0.

You will then run `bundle exec rackup qless.ru -o0.0.0.0 -p 9001` on the
docker container to run a the qless web app and expose it on port 9001.

An example way of running the docker container is to run:

```bash
docker run -d --net="host" -e "REDIS_HOST=localhost" -e "REDIS_PORT=6379" -e "HTTP_PATH=\/qless" <docker_image> bundle exec rackup qless.ru -o0.0.0.0 -p 9001
```

To run the docker container connecting to a specific redis database use:

```bash
docker run -d --net="host" -e "REDIS_HOST=localhost" -e "REDIS_PORT=6379" -e "HTTP_PATH=\/qless"  -e "REDIS_DB=15" <docker_image> bundle exec rackup qless.ru -o0.0.0.0 -p 9001
```

Assuming that the docker container is running on `localhost`, then to
access the web UI, you can run:

```bash
curl http://localhost:9001/qless
```
