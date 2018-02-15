#!/bin/bash

sudo apt-get update && apt-get install -y postgresql postgresql-contrib

virtualenv -p python3 env
. env/bin/activate

pip3 install django \
     djangorestframework \
     djangorestframework-camel-case \
     psycopg2

psql postgres -f ./conf/postgresql/create_db.sql
