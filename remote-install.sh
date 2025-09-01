# Remote configuration
remote="https://github.com/choozn/whisker"

# Install
sudo pacman --noconfirm -S git
git clone "$remote"

cd "whisker"
exec "./install.sh"
