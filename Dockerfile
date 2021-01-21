FROM ruby:2.6.5

RUN apt-get update && \
    apt-get install -y mariadb-client nodejs vim --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /izakaya_app

WORKDIR /izakaya_app

ADD Gemfile /izakaya_app/Gemfile
ADD Gemfile.lock /izakaya_app/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /izakaya_app
