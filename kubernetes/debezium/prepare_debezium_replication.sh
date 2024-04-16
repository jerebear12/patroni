#!/bin/bash

# Variables
DB_NAME="citus"
USER_NAME="postgres"
PUBLICATION_NAME="dbx_publication"
REPLICATION_SLOT_NAME="debezium"
TABLE_NAME="outbox_messages"  # Specify the table you want to include in the publication

# Connect to the PostgreSQL database and create a replication slot and publication
psql -d $DB_NAME -U $USER_NAME -c "SELECT * FROM pg_create_logical_replication_slot('$REPLICATION_SLOT_NAME', 'pgoutput');" || { echo "Failed to create replication slot"; exit 1; }
psql -d $DB_NAME -U $USER_NAME -c "CREATE PUBLICATION $PUBLICATION_NAME FOR TABLE $TABLE_NAME;" || { echo "Failed to create publication"; exit 1; }

echo "Replication slot and publication have been created successfully."
