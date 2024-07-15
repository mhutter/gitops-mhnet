#!/usr/bin/env bash
set -e -u -o pipefail

### Configuration
NS="psql"
CLUSTER="shared"
###

name="$1"
password="$(pwgen -cns 64 1)"

kubectl -n "$NS" exec -c postgres "${CLUSTER}-1" -- psql --command "CREATE DATABASE ${name};"

kubectl -n "$NS" exec -c postgres "${CLUSTER}-1" -- psql --single-transaction <<EOT
CREATE USER $name WITH ENCRYPTED PASSWORD '$password';
GRANT ALL PRIVILEGES ON DATABASE $name TO $name;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO $name;
EOT

echo "Created new database"
echo
echo "  DATABASE_URL: 'postgresql://${name}:${password}@${CLUSTER}-rw.${NS}:5432/${name}'"
