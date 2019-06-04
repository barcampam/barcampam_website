#!/bin/sh

echo "Seeding database"

bin/il_api rpc "Elixir.IlApi.seed"