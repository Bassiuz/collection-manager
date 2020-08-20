FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler -v 2.1.4
RUN bundle install
COPY . .
RUN rails db:migrate RAILS_ENV=production

# Add a script to be executed every time the container starts.
#COPY entrypoint.sh /usr/bin/
#RUN chmod +x /usr/bin/entrypoint.sh
#ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0", "-e", "production"]