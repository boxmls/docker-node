#!/bin/sh

_BRANCH=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD);

echo "Building [boxmls/node:$_BRANCH] image."

docker build --no-cache --tag=boxmls/node:${_BRANCH} .