#!/bin/bash

set -e

export RAILS_ENV=test
export BUNDLE_WITHOUT=development

if [ -x "$(which bower)" ]; then
  bower cache clean
fi
rm -rf vendor/assets/bower_components

bin/setup
bin/rake
