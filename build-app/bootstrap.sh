#!/usr/bin/env bash

#PART 1 : Commands to install the necessary tools

#Note: the current order is the one established by the homework
#Use of yum : yum is the primary tool for getting, installing, deleting, querying, and managing Red Hat Enterprise Linux RPM 
#-y is use to assume yes if its prompted during installation 
# Install Git
sudo yum install git -y

# Install Go
sudo yum install golang -y

# Install NodeJS and npm
curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
sudo yum install nodejs -y
sudo apt-get install npm

# Install Vue cli
sudo npm install -g -y @vue/cli

# Clone testing application from github
git clone https://github.com/jdmendozaa/vuego-demoapp.git

#PART 2: Build the backend
#Access the server folder present in the previously clone repository 
cd vuego-demoapp/server
go build

#PART 3: Move the generated artifacts to the /shared
cd / 
cp /home/vagrant/vuego-demoapp/server/vuego-demoapp /shared/ 

#PART 4: Enviroment variables 
echo 'export PORT=4001' >> /etc/profile
sudo echo 'VUE_APP_API_ENDPOINT="http://localhost:4001/api"' >> /home/vagrant/vuego-demoapp/spa/.env.production.local

#PART 5: Build the frontend
#Vue app
#Spa : frontend store
cd home/vagrant/vuego-demoapp/spa
#Intall npm
sudo npm install 
npm run build

# Part 5: Compress the generated folder and move it to /shared
tar -zcvf dist.tar.gz ./dist
mv dist.tar.gz /shared/

