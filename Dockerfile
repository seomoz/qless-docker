# direct debian works too but is bigger by 40MiB
#FROM debian:jessie
FROM philcryer/min-jessie

# Prevent docker's default encoding of ASCII.
# # https://oncletom.io/2015/docker-encoding/
ENV LANG C.UTF-8
ENV LANGUAGE en_US:C
ENV LC_ALL C.UTF-8

RUN  echo "deb http://ftp.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list && \
 apt-get update && \
 apt-get install -y ruby2.1 git curl && \
 apt-get install -t jessie-backports -y redis-tools && \
 rm -rf /var/lib/apt/lists/*

RUN gem2.1 install bundler

ADD . /qless
WORKDIR /qless

RUN bundle install

# make jquery local, can be removed once https://github.com/seomoz/qless/issues/244 is resolved
RUN curl -o "$(find /var/lib/gems/ -wholename */lib/qless/server/static/js -type d)/jquery.min.js" https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js && \
  patch -d "$(find /var/lib/gems/ -wholename */lib/qless/server -type d)" -p4 < /qless/local_js.patch

EXPOSE 9000

CMD ["bundle", "exec", "rackup", "qless.ru", "-o", "0.0.0.0", "-p", "9000"]
