# QueryHub

## Developer Commands

### Setup

Run the following to update brew, install elixir, yarn, etc. You should only need to run this once:

```
brew update
brew install elixir yarn
mix local.hex
```

Run the following to install/update Elixir dependencies:

```
mix deps.get
```

Run the following to install/update JavaScript dependencies:

```
cd assets && yarn install
```

### Development Infrastructure

Start the local development infrastructure:

```
docker-compose up -d
```

Run the database migrations for all OTP apps which have a database:

```
mix ecto.create
mix ecto.migrate
```

### Testing

Run the Elixir tests for all apps:

```
mix test
```

### Running Locally

Start all of the apps and run all of the servers:

```
mix phx.server
```

Visit [http://localhost:4000](http://localhost:4000) from the browser.

You can also use `iex` to launch an interactive Elixr REPL:

```
iex -S mix
```
