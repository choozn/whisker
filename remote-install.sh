# Remote configuration
remote="https://github.com/choozn/whisker"

# Install
sudo pacman -S git
git clone "$remote"
exec "./install.sh"
