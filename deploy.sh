#!/bin/sh

git co -b master

echo "Deleting old publication"
rm -rf public
mkdir public

hugo
hugo

cd public
git init
git co -b master
git remote add origin git@github.com:pin3da/pin3da.github.com.git
git add -A
git commit -m 'automatic deploy'
git push -f origin master
cd ..
git co src
