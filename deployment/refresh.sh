#!/bin/bash

# stop the old container process
docker stop birdapp

# Remove old contianer process
docker rm birdapp

# pull new version
docker pull patel513/patel-ceg3120:latest

# run from new latest
docker run -d --name birdapp --restart always -p 8080:4200 patel513/patel-ceg3120