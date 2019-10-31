#!/usr/bin/env bash

REPORT_DIRECTORY="$PWD/report"

if [ ! -d "$REPORT_DIRECTORY" ]; then
    mkdir -p "$REPORT_DIRECTORY"
    chmod -R 777 "$REPORT_DIRECTORY"
fi

# Make sure we are using the latest version
docker pull owasp/dependency-check

# Creates docker volume to store NVD database.
docker volume create OWASPDC_DATA
# Tunes owner of the data directory from root to dependencychecker
docker run -it --rm \
    --entrypoint /bin/chown \
    --volume OWASPDC_DATA:/usr/share/dependency-check/data \
    --user root \
    owasp/dependency-check \
    -R 100:101 /usr/share/dependency-check/data

# Runs dependency checker againsr the project
dirname=${PWD##*/}
docker run --rm \
    --volume "$PWD":"/$dirname" \
    --volume OWASPDC_DATA:/usr/share/dependency-check/data \
    --volume "$REPORT_DIRECTORY":/report \
    owasp/dependency-check \
    --scan "/$dirname" \
    --format "ALL" \
    --project "$dirname Dependency Check" \
    --out /report
    # Use suppression like this: (/src == $pwd)
    # --suppression "/src/security/dependency-check-suppression.xml"
