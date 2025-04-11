#!/bin/bash

c=0
while ! curl http://localhost:8010
do
    c=$((c+1))
    if [ "$c" = "12" ]; then
        break
    fi
    sleep 10
done

python /app/src/manage.py loaddata configuration objecttypes objects
echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', 'admin@example.org', 'admin')" | python /app/src/manage.py shell