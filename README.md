# musicbox

## Technology Stack

- Rails 8.0.2
- Ruby 3.4.2
- PostgreSQL 14.5

## Launching the app

### with docker

1. create the .db.env and .rails.local.env files:

```
touch .db.env .rails.local.env
```

2. fill the .rails.local.env file with the following content:

```
GENIUS_CLIENT_ACCESS_TOKEN=something
```

3. bundle and yarn:

```
docker-compose run --rm web-rails bundle install
docker-compose run --rm web-rails yarn install
```

4. run the app:

```
docker-compose up
```

5. visit http://localhost:4000
