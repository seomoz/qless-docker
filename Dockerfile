FROM ubuntu:14.04

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
