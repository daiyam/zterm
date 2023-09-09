#!/bin/bash

set -e

should_publish() {
  VERSION="$(node -p -e "require('./package.json').version")"
  NAME="$(node -p -e "require('./package.json').name")"

  echo "$NAME - $VERSION"
  echo $( npm view $NAME versions | grep "$VERSION" )

  npm view $NAME versions | grep "$VERSION"
}

npm config set loglevel=silent

if [[ -z $( should_publish ) ]]; then
  yarn package-headless
  npm publish --access=public
fi

cd headless
if [[ -z $( should_publish ) ]]; then
  npm publish --access=public
fi

cd ../addons/xterm-addon-canvas
if [[ -z $( should_publish ) ]]; then
  npm publish --access=public
fi

cd ../xterm-addon-image
if [[ -z $( should_publish ) ]]; then
  npm publish --access=public
fi

cd ../xterm-addon-search
if [[ -z $( should_publish ) ]]; then
  npm publish --access=public
fi

cd ../xterm-addon-serialize
if [[ -z $( should_publish ) ]]; then
  npm publish --access=public
fi

# cd ../xterm-addon-unicode11
# if [[ -z $( should_publish ) ]]; then
#   npm publish --access=public
# fi

cd ../xterm-addon-webgl
if [[ -z $( should_publish ) ]]; then
  npm publish --access=public
fi
