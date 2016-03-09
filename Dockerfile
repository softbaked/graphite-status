FROM ruby:2.2.1

RUN apt-get update

EXPOSE 9292

ENV APP_HOME /app
WORKDIR $APP_HOME
ADD ./ $APP_HOME

RUN bundle check || bundle install
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0"]

# docker build -t graphite-noti .
# docker run --rm -p 9292:9292 -v /Users/Xier/Documents/page365-vagrant/work/graphite-noti/example.config.json:/app/config.json graphite-noti
