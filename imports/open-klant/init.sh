#!/bin/bash

echo ">>>>  Starting Open Klant data import script  <<<<"

sh /docker-entrypoint-initdb.d/database/fill-data-on-startup.sh  &
