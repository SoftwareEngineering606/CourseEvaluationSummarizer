# CourseEvaluationSummarizerProject

## Installation and Setup guide


### Install ruby and rails

Please check whether you have the ruby and rails installed. 
```
ruby -v
```
Ruby version is 3.2.2
```
rails -v
```
The rails version is 7.0.8

If you don't have the ruby or rails. Please follow the below processes.

1. Install rbenv
```
•	cd ~
•	curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
```

2. Verify ~/.zshrc file contains the path variables, if not add them:
   
```   
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
```
3. Reload zshrc :
```
source ~/.zshrc
```
   
4. Install Ruby :
```
rbenv install 3.2.2
```

5. Go to a ruby project folder

```
Set ruby 3.2.2 as the local default version: rbenv local 3.2.2
Set 3.2.2 as the global version : rbenv global 3.2.2
gem install bundler
```
6. Verify the ruby and rails installed.
```
ruby -v
```
Ruby version is 3.2.2
```
rails -v
```
If rails not found, use the gem install command:
```
gem install rails
```
The rails version is 7.0.8

### Install the dependencies
1. Install the dependenices :
```
bundle install
```


2. In case you see any error related to libyaml not found, follow the below steps:
```
•	Install Homebrew : /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
•	brew install autoconf automake libtool

•	Clone libyaml repo: git clone https://github.com/yaml/libyaml.git
•	Be in libyaml directory: cd libyaml
•	Bootstrap: ./bootstrap
•	Configure: ./configure
•	Build: make
•	Install: sudo make install
```

3. Install Node.js for handling Javascript in our Rails apps

Download Node.js from https://nodejs.org/en/
or from terminal using : 
```
brew install node
```

4. Install yarn ( JavaScript package manager)

Run in terminal: 
```
brew install yarn
```

5. Install postgresql DB:
Heroku recommends using PostgreSQL during development as Sqlite3 is not compatible with Heroku.

```
•	Download POSTgreSQL from https://postgresapp.com/downloads.html
•	Add the below path to ~/.bash_profile 
•	export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:${PATH}"
```
We can also install postgreDB from terminal using brew:
```
•	brew cask install postgres
•	export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:${PATH}"
•	source ~/.bash_profile 
```
After the installation, verify the version:
```
psql –version
```


6.	Install dependencies again:
```
bundle install
```

7. Do the PostgreSQL database migration :
```
rails run db:migrate
```

8. Run the rails server locally:
```
rails s
```

Go to  http://localhost:3000 in a browser and verify the “Hello! Welcome to Ruby on Rails” page.

---------------------------------------------------------------------------------------------------------------------------

## Running Cucumber Tests

Run the following command to execute the Cucumber tests:

```
bundle exec cucumber
```

Cucumber will run all the feature files and display the test results in the terminal.

## Running RSpec Tests
Run the following command to execute the RSpec tests:

```
bundle exec rspec
```
RSpec will run all the test files and display the test results in the terminal.

## Running Rubocop
Run the following command to execute Rubocop:
```
bundle exec rubocop
```
Rubocop will analyze your codebase and display any style violations or offenses in the terminal.

## Running Rubycritic
Run the following command to generate the code quality report:
```
bundle exec rubycritic
```
Rubycritic will analyze your codebase and generate an HTML report containing a summary of the code quality metrics. The report is usually saved in the tmp/rubycritic directory.

---------------------------------------------------------------------------------------------------------------------------

## Ruby on Rails App Deployment to Heroku with PostgreSQL

Prerequisites
Before you begin, make sure you have the following prerequisites installed:

Ruby
Rails
Heroku CLI
Git
PostgreSQL

1. The installation of Heroku CLI is different based on OS: Please follow the guide: https://devcenter.heroku.com/articles/heroku-cli

Login to your Heroku account:

```
heroku login
```

Create a new Heroku app:

```
heroku create <app_name>
```

Add Heroku PostgreSQL add-on to your app:

```
heroku addons:create heroku-postgresql:hobby-dev
```

Migrate your database on Heroku:

```
heroku run rake db:migrate
```

Push your code to Heroku:

```
git push heroku master
```

View deployed APP:

```
heroku open
```
you also can click the url returned by this command, if the webpage didn't open automatically. 


