FROM ruby:3.1.2-bullseye
LABEL maintainer="maximilian@konow.ski"


### General Setup Stuff
# Add basic packages
RUN apt update && apt install -y --no-install-recommends \
       build-essential \
       openssh-server \
       git \
       tzdata \
       file && \
       curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&\
       echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
       curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
       apt update && \
       apt install yarn nodejs -y

WORKDIR /home/site/wwwroot

# Setup for Azure Web-SSH
RUN echo "root:Docker!" | chpasswd \
    && /usr/bin/ssh-keygen -A \
    && sed -i "s/root:\/root/root:\/home\/site\/wwwroot/g" /etc/passwd
COPY config/docker/sshd_config /etc/ssh/sshd_config

# Setup startup script for entrypoint
COPY config/docker/startup.sh /opt/startup/init_container.sh
RUN ["chmod", "+x", "/opt/startup/init_container.sh"]
ENTRYPOINT ["/opt/startup/init_container.sh"]


### App Stuff

# Install gems
COPY Gemfile* ./

# Install Ruby gems (for production only)
RUN bundle config --local without 'development test' && \
    bundle install -j4 --retry 3 && \
    # Remove unneeded gems
    bundle clean --force && \
    # Remove unneeded files from installed gems (cached *.gem, *.o, *.c)
    rm -rf /usr/local/bundle/cache/*.gem && \
    find /usr/local/bundle/gems/ -name "*.c" -delete && \
    find /usr/local/bundle/gems/ -name "*.o" -delete

# Copy the whole application folder into the image
COPY . .

RUN mv config/credentials.yml.enc config/credentials.yml.enc.bak 2>/dev/null || true
RUN RAILS_ENV=production \
    SECRET_KEY_BASE=dummy \
    RAILS_MASTER_KEY=dummy \
    bundle exec rails assets:precompile
RUN mv config/credentials.yml.enc.bak config/credentials.yml.enc 2>/dev/null || true

# Remove folders not needed in resulting image
RUN rm -rf tmp/cache

# Expose Puma port
EXPOSE 8080
# Expose SSH port
EXPOSE 2222

# Configure Rails
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_ENV production

CMD ["bin/rails", "server", "-p", "8080" ]
