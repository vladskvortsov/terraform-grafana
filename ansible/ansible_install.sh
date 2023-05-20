#/bin/bash

sudo apt-get update -y
sudo apt-get install -y 

git python3-pip

pip install --upgrade ansible
 
ansible-playbook ./ansible/playbook.yml -i ~/terraform-grafana/ansible/hosts.ini -u ubuntu