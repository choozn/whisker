# What's whisker?

Whisker is a collection of all my dotfiles, alongside their respective install scripts.
The project is built in a modular fashion: Each bundle contains packages and configuration files for a specific part of the full setup.
This way, you can pick and choose what you want to install.

# How to install?

Information about the project and a guide to install can be found on https://dots.choozn.dev/.
To install with the simple install script, run the following command on a fresh arch linux installation:

```bash
sh <(curl -Ls dots.choozn.dev)
```

# How to track personal changes?

Once installed, you might want to add your own remote repository to track personal changes to config files.
This is possible and recommended! To help with this, you can follow this guide:

1. Keep original remote as upstream.

```bash
git remote rename origin upstream
```

2. Add your own remote origin to track your changes.

```bash
git remote add origin <YOUR-ORIGIN>
```

# Structure

Whisker is a modular project.
Every part of the setup is organized into what's called a bundle. Each bundle includes software, configurations, and settings tailored for a specific use case or theme.
This modular approach makes it easy to customize your environment by installing only the bundles that fit your needs.

- `/bundles/` - configuration files and installation commands for software components
- `/installs/` - preconfigured lists of bundles for easier installation
- `/whisker/` - bash utilities for installing and managing the dotfiles
