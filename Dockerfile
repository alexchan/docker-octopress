FROM ubuntu:14.04
MAINTAINER alexchan <github@silverprogram.com>

# update OS
# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y upgrade

# Install depndencies
RUN apt-get install -y unzip wget ruby-dev build-essential git vim nodejs

# Build Octopress from github
RUN wget --no-check-certificate -O /tmp/octopress.zip https://github.com/imathis/octopress/archive/master.zip
RUN unzip /tmp/octopress.zip -d /srv/
RUN rm /tmp/octopress.zip

# Install Octopress dependencies
WORKDIR /srv/octopress-master
RUN gem install bundler
RUN bundle install

# Install the default theme
RUN rake install

# Link config files to the mapped directory
RUN mkdir config
RUN mv Rakefile config/
RUN mv _config.yml config/
RUN ln -s config/Rakefile
RUN ln -s config/_config.yml

# Expose default Octopress port
#EXPOSE 4000

# Run Octopress
#ENTRYPOINT ["rake", "preview"]
