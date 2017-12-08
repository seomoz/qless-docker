FROM ruby:2.4.2-slim-stretch

# Prevent docker's default encoding of ASCII.
# # https://oncletom.io/2015/docker-encoding/
ENV LANG C.UTF-8
ENV LANGUAGE en_US:C
ENV LC_ALL C.UTF-8

RUN apt-get update && \
 apt-get install -y build-essential git curl redis-tools && \
 rm -rf /var/lib/apt/lists/*

ADD . /qless
WORKDIR /qless

RUN bundle install

# make jquery local, can be removed once https://github.com/seomoz/qless/issues/244 is resolved
RUN curl -o "$(bundle show qless)/lib/qless/server/static/js/jquery.min.js" https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js && \
  patch -d "$(bundle show qless)/lib/qless/server" -p4 < /qless/local_js.patch

EXPOSE 9000

CMD ["bundle", "exec", "rackup", "qless.ru", "-o", "0.0.0.0", "-p", "9000"]
