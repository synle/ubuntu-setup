function installMacAppIfNotThereAlready(){
    type $@ &> /dev/null ||  brew install $@;
}

echo "Install Homebrew"
type brew &> /dev/null || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Brew install stuffs"
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/homebrew-php
brew unlink php56
brew install php70;
installMacAppIfNotThereAlready jq;
installMacAppIfNotThereAlready fzf;
installMacAppIfNotThereAlready tig;
