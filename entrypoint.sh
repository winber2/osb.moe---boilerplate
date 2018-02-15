#!/bin/bash

supervisord
nginx -g "daemon off;"
