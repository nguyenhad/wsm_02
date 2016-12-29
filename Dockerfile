FROM ubuntu:14.04.5

RUN apt-get update

# basics
RUN apt-get install -y nginx openssh-server git-core openssh-client curl
RUN apt-get install -y nano
RUN apt-get install -y build-essential libmysqlclient-dev

# install RVM, Ruby, and Bundler
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN  \curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash /etc/profile.d/rvm.sh
RUN /bin/bash -l -c "rvm install 2.3.1"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

RUN apt-get update && apt-get install -y nodejs

COPY Gemfile /cache/Gemfile
COPY Gemfile.lock /cache/Gemfile.lock

RUN /bin/bash -l -c "cd /cache && bundle install"

RUN curl -o /usr/bin/framgia-ci https://raw.githubusercontent.com/framgia/ci-report-tool/master/dist/framgia-ci && chmod +x /usr/bin/framgia-ci


#FROM ruby
#RUN apt-get install autoconf libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev
# COPY Gemfile /cache/Gemfile
# COPY Gemfile.lock /cache/Gemfile.lock
# RUN cd /cache && bundle install
# RUN curl -o /usr/bin/framgia-ci https://raw.githubusercontent.com/framgia/ci-report-tool/master/dist/framgia-ci && chmod +x /usr/bin/framgia-ci
