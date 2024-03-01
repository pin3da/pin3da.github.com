#!/bin/sh

echo "Deleting old publication"
rm -rf public

hugo

cd public
git init
git checkout -b main
git remote add origin git@github.com:pin3da/pin3da.github.com.git
git add -A
git commit -m 'automatic deploy'
git push -f origin main
cd ..
git checkout src
