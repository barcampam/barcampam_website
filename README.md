# Barcamp

Requirements:

  * `elixir`
  * `nodejs`
  * `yarn` (install `node` first, then install `yarn` with `npm i -g yarn`, do NOT install it with `brew` or `apt`)
  * `postgresql`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Building Releases

Add a `config/prod.secret.exs` file and put your very secret configs in there:
```
use Mix.Config

config :barcamp, BarcampWeb.Endpoint,
  secret_key_base: "__SECRET_KEY__"

config :barcamp, Barcamp.Repo,
  username: "__DB_USER__",
  password: "__DB_PASSWORD__",
  database: "barcamp_prod",
  hostname: "localhost",
  pool_size: 10
```

You may use `mix phx.gen.secret` to generate a secret key.

Replace the CA in `priv/cert/barcamp_key.pem` and `priv/cert/barcamp.pem` with your public CA.

Build everything:
```
mix deps.get --only prod
MIX_ENV=prod mix compile
yarn --cwd assets install && yarn --cwd assets deploy
mix phx.digest
MIX_ENV=prod mix do ecto.create, release
```

See it in action:
```
mkdir deploy_here
cp _build/prod/rel/barcamp/releases/0.1.0/barcamp.tar.gz deploy_here/
cd deploy_here
tar xvf barcamp.tar.gz
PORT=4001 ./bin/barcamp start
./bin/barcamp migrate
./bin/barcamp create_user login password0!
```

Then navigate to `localhost:4001`.

_Note:_ You do not need to have erlang or elixir where you are deploying a release.

### Updates / Hot-Code-Swap

Bump the version:
```
def project do
   [
    ...
    version: "0.1.1", # Bump the version here
    ...
   ]
end
```

Then:
```
MIX_ENV=prod mix release --upgrade
cp _build/prod/rel/barcamp/releases/0.1.1/barcamp.tar.gz deploy_here/releases/0.1.1/
./deploy_here/bin/barcamp upgrade 0.1.1