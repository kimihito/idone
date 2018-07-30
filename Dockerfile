FROM ruby:rc
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev unzip

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs

# Yarn
RUN npm install -g yarn

# Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' \
    && apt-get update && apt-get install -y google-chrome-stable

WORKDIR /shuho
# ADD package.json /shuho/package.json
# ADD yarn.lock /shuho/yarn.lock
# RUN yarn install
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install --jobs 4
ADD . /shuho
