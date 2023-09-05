#!/bin/bash

export RINGS='["BRUK", "VURDER", "AVSTÅ"]'
export QUADRANTS='["Programmering", "Devops", "Plattform", "Sikkerhet"]'
export ASSET_PATH="/teknologiradar"

rm -r ./dist
npm run build:prod
cp -r data dist
aws s3 sync ./dist s3://teknologiradar-origo/ --delete
