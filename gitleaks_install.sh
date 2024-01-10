#!/bin/bash

# Determine OS name
os=$(uname)

# Install git
if [ "$os" = "Linux" ]; then
  pip install pre-commit
  curl -X GET --data-binary @payload.yaml -H "Content-type: text/x-yaml" https://raw.githubusercontent.com/AntinDehoda/kbot/gitleaks/.pre-commit-config.yaml  >> .pre-commit-config.yaml
  pre-commit autoupdate
  pre-commit install
elif [ "$os" = "Darwin" ]; then
  brew install pre-commit
  brew install gitleaks
else
  echo "Unsupported OS"
  exit 1

fi
git config gitleaks.enable true
echo "Gitleaks installed!"
