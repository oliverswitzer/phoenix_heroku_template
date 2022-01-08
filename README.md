# Phoenix Template App 

This is a template for Phoenix apps that can be deployed to Heroku

First, replace all instances of `RenameMe` in the app with your app name. I use
this [Vim tool](https://github.com/brooth/far.vim) to do this.

`:Far RenameMe YourElixirModuleName **/*`
`:Fardo`
`:Far rename_me your_elixir_module_name **/*`
`:Fardo`

To rename all files, I use a tool called `rename` and `find`

`$ brew install rename`

`$ find . -exec rename 's|rename_me|your_elixir_module_name|' {} +`

# Deployment

Necessary changes have been made to runtime.exs to allow deployments to Heroku.
All you need to do is install the necessary buildpacks and set environment
variables.

1. Install buildpacks

`heroku buildpacks:add hashnuke/elixir`

By default, Phoenix uses esbuild and manages all assets for you. However, if you are using node and npm, you will need to install the Phoenix Static buildpack to handle them:

`heroku buildpacks:add https://github.com/gjaldon/heroku-buildpack-phoenix-static.git`

1. Set these env vars:

heroku config:set DATABASE_URL=<database url generated from heroku>
heroku config:set POOL_SIZE=10
heroku config:set SECRET_KEY_BASE=86mGgSDBIIYBcU3CkJ0v3XWd6cMLDCuJrP9H9R/AMDQ751gfusM6V3krCb4T2PYQ
heroku config:set PHX_HOST=<your heroku domain>

# Local Development

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
