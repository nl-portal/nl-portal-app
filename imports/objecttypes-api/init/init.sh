#!/bin/bash

echo ">>>>  NL Portal init script: Objecttypes API <<<<"
sleep 2
while true
do
    # Checking whether last table is created
    initiated=$(pg_isready -h $DB_HOST -q && psql postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}/postgres -t -A -c "SELECT EXISTS (SELECT table_name FROM information_schema.tables WHERE table_name = 'token_tokenauth');" || "false")
    if [ "t" = "${initiated}" ]
        then
            echo "Database ready."
            echo "Attempting to create admin user:"
            sleep 2
            DJANGO_SUPERUSER_PASSWORD=admin python /app/src/manage.py createsuperuser --username=admin --email=admin@example.com --noinput
            echo "Loading fixtures:"
            sleep 2
            python /app/src/manage.py loaddata configuration objecttypes
            break
        else
            echo "Database is not ready. Retrying in 10 seconds."
            sleep 10
    fi
done

echo ">>>> Done <<<<"
