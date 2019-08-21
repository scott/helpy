#!/bin/bash

echo "migrating database..."
sudo helpy run rake db:migrate
echo "clearing cache..."
sudo helpy run rake tmp:clear