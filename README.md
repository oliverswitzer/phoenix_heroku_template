# Phoenix Template App 

### ◎ This is a boilerplate template for Phoenix apps that can be deployed to Heroku

This boilerplate app uses:

* Phoenix 1.6.3
* elixir 1.12.3-otp-24
* erlang 24.1
* LiveView
* esbuild
* Ecto / Postgres

### 🛠  Setup & Customzie

1. Clone this repo, or click "Use Template" in Github to add to your github repositories

2. Globally replace an easy-to-find placeholder in the app with your desired app name

Replace all instances of `RenameMe` in the app with your app name. I use
this [Vim tool](https://github.com/brooth/far.vim) to do this.

`:Far RenameMe YourElixirModuleName **/*`

`:Fardo`

`:Far rename_me your_elixir_module_name **/*`

`:Fardo`

If you don't use Vim or prefer not to to use that plugin, you can either use an
editor of your choice or you can use the `find` command with `sed`:

`find . -type f -name '**/*' -exec sed -i '' s/RenameMe/YourElixirModuleName/g {} +`

`find . -type f -name '**/*' -exec sed -i '' s/rename_me/your_elixir_module_name/g {} +`

To rename all files, I use a tool called `rename` and `find`

`$ brew install rename`

`$ find . -exec rename 's|rename_me|your_elixir_module_name|' {} +`

3. Run the app!

` mix deps.get && mix phx.server`

If you'd prefer not to use a database, it is relatively easy to disable Ecto; just comment out `RenameMe.Repo,` in `lib/rename_me/application.ex` so it doesn't yell at you when starting up the app.

# 🐿  Deployment

Necessary changes have been made to `config/runtime.exs` to allow deployments to Heroku.
All you need to do is install the necessary buildpacks and set appropriate environment variables.

1. Create heroku app

`heroku create <your-app-name>`

2. Install buildpacks

`heroku buildpacks:add hashnuke/elixir`

By default, Phoenix uses esbuild and manages all assets for you. However, if you are using node and npm, you will need to install the Phoenix Static buildpack to handle them:

`heroku buildpacks:add https://github.com/gjaldon/heroku-buildpack-phoenix-static.git`

3. Set these env vars:

```
heroku config:set DATABASE_URL=<database url generated from heroku>
heroku config:set POOL_SIZE=10
heroku config:set SECRET_KEY_BASE=$(mix phx.gen.secret)
heroku config:set PHX_HOST=<your heroku domain>
```

If `mix phx.gen.secret` fails to run, you may need to compile the app first.

# Local Development

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
