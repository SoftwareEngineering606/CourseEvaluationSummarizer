# CourseEvaluationSummarizerProject

Installation and Setup guide

1. Install rbenv
•	cd ~
•	curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash

2. Verify ~/.zshrc file contains the path variables, if not add them:
   
export PATH=$HOME/.rbenv/bin:$PATH
eval export PATH="/Users/vinodheniramasrinivasan/.rbenv/shims:${PATH}"
export RBENV_SHELL=zsh
source '/Users/vinodheniramasrinivasan/.rbenv/completions/rbenv.zsh'
command rbenv rehash 2>/dev/null
rbenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(rbenv "sh-$command" "$@")";;
  *)
    command rbenv "$command" "$@";;
  esac
}

3. Reload zshrc : source ~/.zshrc
   
4. Install Ruby : rbenv install 3.2.2

5. Go to a ruby project folder
Set ruby 3.2.2 as the local default version: rbenv local 3.2.2
Set 3.2.2 as the global version : rbenv global 3.2.2
gem install bundler

7. Install the dependenices :
bundle install

8. Verify Ruby version :
ruby -v

In case you see any error related to libyaml not found, follow the below steps:

•	Install Homebrew : /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
•	brew install autoconf automake libtool

•	Clone libyaml repo: git clone https://github.com/yaml/libyaml.git
•	Be in libyaml directory: cd libyaml
•	Bootstrap: ./bootstrap
•	Configure: ./configure
•	Build: make
•	Install: sudo make install

9. Install Rails :
    
•	To install Rails, use the gem install command:
gem install rails

•	Once completed, Verify by running:
rails -v

10. Install Node.js for handling Javascript in our Rails apps

Download Node.js from https://nodejs.org/en/
or from terminal using : brew install node

11. Install yarn ( JavaScript package manager)

Run in terminal: brew install yarn

12. Install postgresql DB:
Heroku recommends using PostgreSQL during development as Sqlite3 is not compatible with Heroku.

•	Download POSTgreSQL from https://postgresapp.com/downloads.html
•	Add the below path to ~/.bash_profile 
•	export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:${PATH}"

We can also install postgreDB from terminal using brew:

•	brew cask install postgres
•	export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:${PATH}"
•	source ~/.bash_profile 

After istalling, verify the version:
psql –version

13. Create a new Rails App:

•	Go to a desired folder location and create a new app with the following command:
rails new myapp --database=postgresql

•	Go into the project folder and add the x86_64-linux and ruby platforms to Gemfile.lock.
cd myapp
bundle lock --add-platform x86_64-linux --add-platform ruby

•	Create a local database:
bin/rails db:create

•	Install dependencies :
bundle install

14. To create a basic Hello World Rails App:

•	Create a welcome controller :
 rails generate controller welcome

•	Create index.HTML in app/views/welcome/index.html
 <h2>Hello! Welcome to Ruby on Rails</h2>

•	Create a route to map to this action. In config/routes.rb, add:
  root 'welcome#index'

•	Start rails server:
 rails server

Go to  http://localhost:3000 in a browser and we can see the “Hello! Welcome to Ruby on Rails” page.
---------------------------------------------------------------------------------------------------------------------------






