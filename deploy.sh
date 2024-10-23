#!/bin/sh

# run : sh deploy.sh
flutter build web

cd build/web

git init
git add .
git commit -m "Deploy to GitHub Pages"

git push --force git@github.com:TilarnaExdilika/FieryGG---Flutter-Dribble-UI-Demo.git main:gh-pages

cd -