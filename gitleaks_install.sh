#!/bin/bash

# Determine OS name
os=$(uname)

# Install git
if [ "$os" = "Linux" ]; then
  pip install pre-commit
  curl https://github.com/AntinDehoda/kbot/.pre-commit-config.yaml -L -O
  pre-commit autoupdate
  pre-commit install
elif [ "$os" = "Darwin" ]; then
  brew install pre-commit
  brew install gitleaks
else
  echo "Unsupported OS"
  exit 1

fi
git config gitleaks.enable=true
echo "Gitleaks installed!"
