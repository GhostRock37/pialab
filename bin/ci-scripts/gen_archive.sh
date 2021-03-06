#!/usr/bin/env bash
set -ex

Name=Pialab-front

if [ -z ${Branch} ]
then
    Branch=$(git name-rev  --name-only $(git rev-parse HEAD) | sed -e s/\\^.*//g | awk -F'/' '{print $(NF)}')
fi

# Clean current git dir
git clean -df
git checkout -- .

Filename=${Name}_${Branch}.tar.gz

rm -f ${Filename}

rm -rf \
   *.log \
   *.nbr \
   *.dist

tar --exclude-vcs \
    --exclude=build \
    --exclude=bin/git-scripts \
    -czhf ${Filename} ./*

sha256sum ${Filename} > ${Filename}.sha256.txt
