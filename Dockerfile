# jekyll-server
#
#
# Assumes you have a directory that contains a Jekyll site.
#
# Building the Image
#
# 1.  Copy your site's `Gemfile` and `Gemfile.lock`
#     to the build directory (usually the directory that
#     contains this file).
#
#     `cp /path/to/your/site/Gemfile* .`
#
# 2.  Build the image:
#
#     `docker build --no-cache  -t pborenstein/jekyll-server .``
#
# Running the Image
#
# 1.  cd <your site>
# 2.  docker run \
#     -p 81:4000 \    # port
#     -v (pwd):/site  # this directory
#     -e JEKYLL_CLEAN=true  # optional to run `jekyll clean` before server
#     pborenstein/jekyll-server

FROM ruby:2.4-alpine
LABEL maintainer=$"pborenstein@gmail.com" \
      version="2.0" \
      description="Runs jekyll serve on mounted directory" \
      description="Adapted from https://github.com/BretFisher/jekyll-serve"

EXPOSE 4000
WORKDIR /site
ENV JEKYLL_CLEAN false

RUN apk add --no-cache build-base gcc bash

COPY docker-entrypoint.sh /usr/local/bin/
COPY Gemfile /site
COPY Gemfile.lock /site

RUN gem install jekyll
RUN bundle install

ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "bundle", "exec", "jekyll", "serve", "--force_polling", "--watch", "--incremental", "-H", "0.0.0.0", "-P", "4000" ]
