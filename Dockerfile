FROM ruby:2.6.3
LABEL maintainer="daniel@foxsoft.co.uk"
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y \
    nodejs                                   \
    postgresql-client                        \
    graphviz                                 \
    build-essential                          \
    yarn

ENV APP_HOME /usr/src/app

WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN bundle install

COPY . $APP_HOME/

# Add a script to be executed every time the container starts.
COPY docker/entrypoint /usr/bin/
RUN chmod +x /usr/bin/entrypoint
ENTRYPOINT ["entrypoint"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
