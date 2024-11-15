FROM hasura/graphql-engine:v2.44.0

# Copy the fixie-wrench binary into the container
COPY bin/fixie-wrench-linux-amd64 /bin/

# Make sure it's executable
RUN chmod +x /bin/fixie-wrench-linux-amd64

# Enable the console
ENV HASURA_GRAPHQL_ENABLE_CONSOLE=true
# Enable debugging mode. It should be disabled in production.
ENV HASURA_GRAPHQL_DEV_MODE=true
# Heroku hobby tier PG has few limitations including 20 max connections
# https://devcenter.heroku.com/articles/heroku-postgres-plans#hobby-tier
ENV HASURA_GRAPHQL_PG_CONNECTIONS=15

CMD /bin/fixie-wrench-linux-amd64 $POSTGRES_PORT:$POSTGRES_HOST:$POSTGRES_PORT & \
    graphql-engine \
    serve \
    --server-port $PORT
