#!/bin/bash

sudo apt-get update && apt-get install -y postgresql postgresql-contrib virtualenv
virtualenv -p python3 env
psql postgres -f ./conf/postgresql/create_db.sql
