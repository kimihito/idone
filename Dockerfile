FROM ruby:2.6.5
ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev unzip libldap2-dev libidn11-dev fonts-migmix libjemalloc-dev imagemagick sudo

ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs

# Yarn
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && sh -c 'echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list' \
    && apt-get update -qq && apt-get install -y yarn

# Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list' \
    && apt-get update -qq && apt-get install -y google-chrome-stable

# Chromedriver
RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` \
  && mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION \
  && curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip \
  && unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION \
  && rm /tmp/chromedriver_linux64.zip \
  && chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver \
  && ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver

# add sudo user
RUN groupadd -g 1000 idone && \
    useradd  -g      idone -G sudo -m -s /bin/bash idone && \
    echo 'idone:idone' | chpasswd

RUN echo 'Defaults visiblepw'             >> /etc/sudoers
RUN echo 'idone ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER idone

WORKDIR /idone
COPY entrypoint.sh /usr/bin
RUN sudo chmod +x /usr/bin/entrypoint.sh
RUN sudo chown -R idone:idone .
ADD package.json /idone/package.json
ADD yarn.lock /idone/yarn.lock
RUN yarn install
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install --jobs 4
ADD . /idone

RUN sudo apt-get autoremove -y \
    && sudo apt-get clean -y \
    && sudo rm -rf /var/lib/apt/lists/*


ENTRYPOINT [ "entrypoint.sh" ]