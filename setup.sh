#!/bin/bash

sudo apt-get update && apt-get install -y postgresql postgresql-contrib virtualenv
virtualenv -p python3 env
psql postgres -f ./conf/postgresql/create_db.sql

. env/bin/activate
sudo pip3 install -r requirements.txt
python3 manage.py makemigrations
python3 manage.py migrate
python3 manage.py collectstatic
