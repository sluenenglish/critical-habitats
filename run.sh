#!/bin/bash
export RUBY_VERSION=2.6

ruby_run() {
  docker run \
    --rm \
    --volume="$PWD:/srv/" \
    --volume="$PWD/vendor/bundle:/usr/local/bundle" \
    -w="/srv/" \
    -p "8000:8000" \
    -e "LC_ALL=C.UTF-8" \
    -it ruby:$RUBY_VERSION \
    "$@"
}

build() {
  echo "Building..."
  ruby_run bundle exec jekyll build --trace
}

install() {
  echo 'Installing Packages...'
  ruby_run bundle install
}

serve() {
  echo "Starting dev server..."
  ruby_run bundle exec jekyll serve --host=0.0.0.0 --port=8000
}

"$@"
