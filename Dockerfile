FROM ruby:2.2.1

RUN apt-get update

EXPOSE 9393

ENV APP_HOME /app
WORKDIR $APP_HOME
ADD ./ $APP_HOME

RUN bundle check || bundle install
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "9393"]
