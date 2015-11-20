FROM ubuntu:14.04

# Prevent docker's default encoding of ASCII.
# # https://oncletom.io/2015/docker-encoding/
ENV LANG C.UTF-8
ENV LANGUAGE en_US:C
ENV LC_ALL C.UTF-8

# PPA for Ruby 2.1
RUN apt-get update
RUN apt-get install -y python3-software-properties software-properties-common
RUN add-apt-repository ppa:chris-lea/redis-server
RUN apt-add-repository ppa:brightbox/ruby-ng
RUN apt-get update
RUN apt-get install -y ruby2.1 redis-tools git

RUN gem install bundler

ADD . /qless
WORKDIR /qless

RUN bundle install
