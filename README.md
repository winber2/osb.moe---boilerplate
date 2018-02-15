## Setting up the environment

run `./setup.sh`

This should pip install dependencies as well as setup the postrges database on port `5432`

In order to run locally, you will need to migrate the default django migrations:

`python3 manage.py makemigrations`
`python3 manage.py migrate`

Then collect the static files needed to certain django apps to run:

`python3 manage.py collectstatic`

## Deploying Locally

Make sure you have docker, then run:

`./deploy.sh`

This should deploy a docker container as an exposed server, which you can access by going to `localhost`

## Running Locally

Deploying with docker basically mimics production, which runs NGINX and gunicorn on top of the django application.

You can alternatively just run `python3 manage.py runserver` to run a local django server on port `8000` without NGINX or gunicorn.
