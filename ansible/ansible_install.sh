#/bin/bash

sudo apt-get update -y
sudo apt-get install -y 

git python3-pip

pip install --upgrade ansible
sudo ansible-playbook ~/ansible/playbook.yml -i ~/ansible-drupal-deploy/hosts.ini -u ubuntu
