FROM ubuntu:16.04

RUN apt-get update && apt-get install -y python3-pip \
    supervisor \
    postgresql-client-common \
    postgresql-client-9.5 \
    nginx \
    vim

RUN pip3 install django \
         djangorestframework \
         djangorestframework-camel-case \
         gunicorn \
         psycopg2

# configuration
ADD ./conf/supervisor/osb.conf /etc/supervisor/conf.d/
ADD ./conf/nginx/osb /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/osb /etc/nginx/sites-enabled/
RUN rm /etc/nginx/sites-enabled/default
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone
RUN mkdir -p /var/log/gunicorn
RUN mkdir -p /var/log/nginx
ADD ./entrypoint.sh /
RUN chmod u+x /entrypoint.sh

# source
ADD ./osb /var/www/osb
ADD ./api /var/www/api
ADD ./osb.moe/public /var/www/html
ADD ./manage.py /var/www/

# static files
ADD ./static /var/www/static

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
