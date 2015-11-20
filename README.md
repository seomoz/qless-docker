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

You will then run `bundle exec rackup qless.ru -o0.0.0.0 -p 9001` to run
the qless web app and expose it on port 9000.
