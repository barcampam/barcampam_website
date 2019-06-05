#!/bin/sh

echo "Creating user..."

bin/barcamp rpc "Elixir.Barcamp.Auth.create_user(%{login: \"$1\", password: \"$2\"})"