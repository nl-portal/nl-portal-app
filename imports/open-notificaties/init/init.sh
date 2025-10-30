#!/bin/bash

echo ">>>>  NL Portal init script: Open Notificaties <<<<"
sleep 2
while true
do
    # Checking whether last table is created
    initiated=$(pg_isready -h $DB_HOST -q && psql postgresql://$DB_NAME:$DB_PASSWORD@$DB_HOST -t -A -c "SELECT EXISTS (SELECT table_name FROM information_schema.tables WHERE table_name = 'zgw_consumers_service');" || "false")
    if [ "t" = "${initiated}" ]
        then
            echo "Database ready."
            echo "Loading fixtures:"
            sleep 2
            python /app/src/manage.py loaddata configuration kanalen
            break
        else
            echo "Database is not ready. Retrying in 10 seconds."
            sleep 10
    fi
done

echo ">>>> Done <<<<"
