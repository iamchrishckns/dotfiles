#!/usr/bin/env bash

brew_packages=(
  "node"
  "pnpm"
  "go"
  "php"
  "composer"
)

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo "Homebrew is not installed. Please install Homebrew first."
  exit 1
fi

# Ask for confirmation before proceeding
echo "This script will install the following packages using Homebrew: "
for package in "${brew_packages[@]}"; do
  echo "- $package"
done

read -p "Do you want to proceed? (y/N): " confirm_homebrew

if [[ ! "$confirm_homebrew" =~ ^[Yy]$ ]]; then
  echo "Installation aborted."
  exit 0
fi

# Install packages using Homebrew
for package in "${brew_packages[@]}"; do
  if ! brew list --formula | grep -q "^${package}\$"; then
    echo "Installing $package..."
    brew install "$package"
  else
    echo "$package is already installed."
  fi
done

echo "Homebrew packages installed successfully."
echo ""
echo "#########################################################################################################################"
echo ""

pecl_packages=(
   "xdebug"
)

# Check if PECL is installed
if ! command -v pecl &> /dev/null; then
  echo "PECL is not installed. Please install PECL first."
  exit 1
fi  

# Ask for confirmation before proceeding
echo "This script will install the following PECL packages: "
for package in "${pecl_packages[@]}"; do
  echo "- $package"
done

read -p "Do you want to proceed? (y/N): " confirm_pecl

if [[ ! "$confirm_pecl" =~ ^[Yy]$ ]]; then
  echo "Installation aborted."
  exit 0
fi

# Install PECL packages
for package in "${pecl_packages[@]}"; do
  if ! pecl list | grep -q "^${package}\$"; then
    echo "Installing $package..."
    pecl install "$package"
  else
    echo "$package is already installed."
  fi
done

echo "Pecl packages installed successfully."
echo ""
echo "#########################################################################################################################"
echo ""


# Install composer global packages
composer_global_packages=(
  "laravel/installer"
)

# Check if composer is installed
if ! command -v composer &> /dev/null; then
  echo "Composer is not installed. Please install composer first."
  exit 1
fi

# Ask for confirmation before proceeding
echo "This script will install the following composer global packages: " 
for package in "${composer_global_packages[@]}"; do
  echo "- $package"
done

read -p "Do you want to proceed? (y/N): " confirm_composer
if [[ ! "$confirm_composer" =~ ^[Yy]$ ]]; then
  echo "Installation aborted."
  exit 0
fi

# Install Composer global packages
for package in "${composer_global_packages[@]}"; do
  if ! composer global show | grep -q "^${package}\$"; then
    echo "Installing $package..."
    composer global require "$package"
  else
    echo "$package is already installed."
  fi
done

echo "Composer global packages installed successfully."
echo ""
echo "#########################################################################################################################"
echo ""
echo "All development packages have been installed successfully."
echo "You may need to restart your terminal or run 'reload_zsh' to apply the changes."
echo ""
echo "#########################################################################################################################"
echo ""
