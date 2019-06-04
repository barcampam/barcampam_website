#!/bin/sh

echo "Running migrations"

bin/il_api rpc "Elixir.IlApi.migrate"