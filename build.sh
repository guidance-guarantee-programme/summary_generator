#!/bin/bash -l

set -e

unset RUBYOPT
export BUNDLE_WITHOUT="test:development"

if [ -x "$(which bower)" ]; then
  bower cache clean
fi
rm -rf vendor/assets/bower_components

bin/setup
bundle package --all
RAILS_ENV=production RAILS_GROUPS=assets bin/rake assets:precompile
