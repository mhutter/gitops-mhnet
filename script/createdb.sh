#!/usr/bin/env bash
set -e -u -o pipefail

### Configuration
NS="psql"
CLUSTER="shared"
###

pod="$(kubectl -n "$NS" get pod -o name -l "cnpg.io/cluster=${CLUSTER}" -l "cnpg.io/instanceRole=primary")"
name="$1"
password="$(pwgen -cns 64 1)"

kubectl -n "$NS" exec -c postgres "$pod" -- psql --command "CREATE USER ${name} WITH ENCRYPTED PASSWORD '$password';"
kubectl -n "$NS" exec -c postgres "$pod" -- psql --command "CREATE DATABASE ${name} OWNER ${name};"

echo "Created new database"
echo
echo "  DATABASE_URL: 'postgresql://${name}:${password}@${CLUSTER}-rw.${NS}:5432/${name}'"
