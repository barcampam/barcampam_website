# Import all plugins from `rel/plugins`
# They can then be used by adding `plugin MyPlugin` to
# either an environment, or release definition, where
# `MyPlugin` is the name of the plugin module.
~w(rel plugins *.exs)
|> Path.join()
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
  # This sets the default release built by `mix release`
  default_release: :default,
  # This sets the default environment used by `mix release`
  default_environment: Mix.env()

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/config/distillery.html

# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  # If you are running Phoenix, you should make sure that
  # server: true is set and the code reloader is disabled,
  # even in dev mode.
  # It is recommended that you build with MIX_ENV=prod and pass
  # the --env flag to Distillery explicitly if you want to use
  # dev mode.
  set(dev_mode: true)
  set(include_erts: false)
  set(cookie: :"JyK|1A2R$XOfn?yW/&{D*wpikMp!YL/*,op`~d~.$^T7u0W@BM{=`?|>&3`oj.u~")
end

environment :prod do
  set(include_erts: true)
  set(include_src: false)
  set(cookie: :"bV7~ubUJYzO::j;VJ|Ys]:|Pfb%Fw&NKVp[@7AptqrKGj8oZ^s/i4QgE)fn%|2aB")
  set(vm_args: "rel/vm.args")
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :barcamp do
  set(version: current_version(:barcamp))

  set(
    applications: [
      :runtime_tools
    ]
  )

  set(
    commands: [
      migrate: "rel/commands/migrate.sh",
      seed: "rel/commands/seed.sh",
      create_user: "rel/commands/create_user.sh"
    ]
  )
end
