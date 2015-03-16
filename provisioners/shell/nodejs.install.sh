#!/bin/bash

# Install Node.js Using a PPA
# Resources: https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-an-ubuntu-14-04-server
curl -sL https://deb.nodesource.com/setup | sudo bash -
apt-get install -y nodejs
