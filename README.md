# osb.moe boilerplate

Basically just testing things with docker, and setting up boilerplate for osb.moe react.

## Setting up the environment

run `./setup.sh`

This should pip install dependencies as well as setup the postrges database on port `5432`. An `env` folder should have been created in the setup. Enter the environment and install django dependencies by running:

- `. env/bin/activate`
- `sudo pip3 install -r requirements.txt`

In order to run the django application, you will need to migrate the default django migrations:

- `python3 manage.py makemigrations`
- `python3 manage.py migrate`

Then collect the static files needed for certain django apps to run:

- `python3 manage.py collectstatic`

## Deploying Locally

Make sure you have docker, then run:

- `./deploy.sh`

This should deploy a docker container as an exposed server, which you can access by going to `localhost`

## Running Locally

Deploying with docker basically mimics production, which runs NGINX and gunicorn on top of the django application.

You can alternatively just run `python3 manage.py runserver` to run a local django server on port `8000` without NGINX or gunicorn.

## Developing

This application uses React and Django. Django will be purely used for API's and the majority of the application will be frontend developing in React. While having one of the backends running (either using `python manage.py runserver` or using the docker deployment), you can start a local frontend serving server using webpack-dev-server:

- `cd osb.moe`
- `npm install` to install node dependencies if needed
- `npm run start` to start up the webpack-dev-server

You will then be able to see the frontend served at `localhost:3000`. Changes inside the osb.moe folder will update immediately in your browser, so it makes for faster React development.
