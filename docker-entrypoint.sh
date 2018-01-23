#!/bin/bash
set -e

if [ ! -f Gemfile ]; then
  echo "No Gemfile found in /site directory."
  echo "Remember to mount a directory when you run this container:"
    echo ""
    echo "docker run -p 80:4000 -v \$(pwd):/site pborenstein/jekyll-server"
  echo ""
  exit 1
fi

if [ "$JEKYLL_CLEAN" = true ] ; then
  jekyll clean
fi

exec "$@"
