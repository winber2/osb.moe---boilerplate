#!/bin/bash

cd osb.moe
npm run build
cd ../

docker build -t osb:dev .
docker kill $(docker ps -a | grep hifumi_hentai | cut -c-12)
docker rm $(docker ps -a | grep hifumi_hentai | cut -c-12)
docker run --net host -d -p 80:80 --name=hifumi_hentai osb:dev
