#!/bin/sh

# Define the MongoDB connection string
MONGO_URL="mongodb://${MONGO_INITDB_ROOT_USERNAME}:${MONGO_INITDB_ROOT_PASSWORD}@${ME_CONFIG_MONGODB_SERVER}:${MONGO_PORT}"

echo "Configuring mongo-express with server: $ME_CONFIG_MONGODB_SERVER"

# Optionally, you can generate a custom configuration file here if needed.
cat << EOF > /mongo-express-config.json
{
    "mongodb": {
        "server": "${ME_CONFIG_MONGODB_SERVER}",
        "port": ${MONGO_PORT},
        "admin": true,
        "auth": [
            {
                "database": "admin",
                "username": "${MONGO_INITDB_ROOT_USERNAME}",
                "password": "${MONGO_INITDB_ROOT_PASSWORD}"
            }
        ]
    },
    "site": {
        "baseUrl": "/",
        "cookieSecret": "keyboard cat",
        "sessionSecret": "keyboard cat",
        "username": "${MONGO_EXPRESS_USERNAME}",
        "password": "${MONGO_EXPRESS_PASSWORD}"
    }
}
EOF

echo "mongo-express configuration file created successfully."
cat /mongo-express-config.json

echo "Starting mongo-express..."
exec /docker-entrypoint.sh
