#!/bin/bash

export RINGS='["BRUK", "VURDER", "AVSTÅ"]'
export QUADRANTS='["Programmering", "Devops", "Plattform", "Sikkerhet"]'
export ASSET_PATH="/"

rm -r ./dist
npm run build:dev
cp -r data dist
aws s3 sync ./dist s3://teknologiradar-origo-dev/ --delete
