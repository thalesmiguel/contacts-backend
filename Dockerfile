FROM ruby:2.7.2-alpine

RUN apk update && apk add bash build-base tzdata sqlite sqlite-dev ruby-dev

RUN mkdir /contacts-backend
WORKDIR /contacts-backend

COPY Gemfile Gemfile.lock ./
# RUN gem install sqlite3 -v '1.4.2'
RUN gem install bundler --no-document
RUN bundle install --no-binstubs --jobs $(nproc) --retry 3

COPY . .

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
