
## Building and Running

You'll need a few things before we get started. 
Make sure you have Xcode installed from the App Store. 
Then run the following command to install Xcode's command line tools, if you don't have that yet
```sh
xcode-select --install
```

Install [`Bundler`](https://bundler.io) for managing Ruby gem dependencies
```sh
[sudo] gem install bundler
```

Install [Brew](https://github.com/Homebrew/brew) package manager for macOS
```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Install [`Node`](https://nodejs.org/en/) 
```sh
brew install node
```

The following commands will set up
```sh
cd SwiftHub
bundle install
bundle exec fastlane setup
```

To update all tools and pods
```sh
bundle exec fastlane update
```

