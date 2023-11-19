# CourseEvaluationSummarizerProject
---------------------------------------------------------------------------------------------------------------------------
## First: Contact information

Kangdong Yuan
kky5082@tamu.edu
8148528757

### Important information, if you have any problem with environment setup, app running, or deployment. Please text or call me.
---------------------------------------------------------------------------------------------------------------------------
## Second: Installation and Setup guide


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

1. Install the dependencies :
```
bundle install
```
#### The following commands are for Mac OS, if you use Linux, you can use apt install with Linux ubuntu

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

3. Install postgresql DB:
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
The postgres install guide for ubuntu

```
sudo apt install postgresql
```

After the installation, verify the version:
```
psql –version
```


4.	Install dependencies again:
```
bundle install
```
---------------------------------------------------------------------------------------------------------------------------
## Third: Run the local server

1. Do the PostgreSQL database migration :
```
rails run db:migrate
```

2. Run the rails server locally:
```
rails s
```

Go to  http://localhost:3000 in a browser and verify the “Hello! Welcome to Ruby on Rails” page.

---------------------------------------------------------------------------------------------------------------------------
## Fourth: Test and coverage

### Running Cucumber Tests

Run the following command to execute the Cucumber tests:

```
bundle exec cucumber
```

Cucumber will run all the feature files and display the test results in the terminal.

### Running RSpec Tests
Run the following command to execute the RSpec tests:

```
bundle exec rspec
```
RSpec will run all the test files and display the test results in the terminal.

#### The comprehensive test coverage needs to run Rspec and cucumber. You will see the coverage percentage after run two commands. 

### Running Rubocop
Run the following command to execute Rubocop:
```
bundle exec rubocop
```
Rubocop will analyze your codebase and display any style violations or offenses in the terminal.

### Running Rubycritic
Run the following command to generate the code quality report:
```
bundle exec rubycritic
```
Rubycritic will analyze your codebase and generate an HTML report containing a summary of the code quality metrics. The report is usually saved in the tmp/rubycritic directory.

---------------------------------------------------------------------------------------------------------------------------

## Fifth: Ruby on Rails App Deployment to Heroku with PostgreSQL

Prerequisites
Before you begin, make sure you have the following prerequisites installed:

Ruby
Rails
Heroku CLI
Git
PostgreSQL

1. The installation of Heroku CLI is different based on OS: Please follow the guide: https://devcenter.heroku.com/articles/heroku-cli

2. Login to your Heroku account:

```
heroku login
```

3. Create a new Heroku app:

```
heroku create <app_name>
```

4. Add Heroku PostgreSQL add-on to your app:

```
heroku addons:create heroku-postgresql:hobby-dev
```

5. Migrate your database on Heroku:

```
heroku run rake db:migrate
```

6. Push your code to Heroku:

```
git push heroku master
```
If you meet the error said: "Detecting rails configuration failed, set HEROKU_DEBUG_RAILS_RUNNER=1 to debug"
Please run the following command and run the git push again:
```
heroku config:set HEROKU_DEBUG_RAILS_RUNNER=1 
```

7. View deployed APP:

```
heroku open
```
you also can click the url returned by this command, if the webpage didn't open automatically. 

---------------------------------------------------------------------------------------------------------------------------

## Sixth: How to use the APP

1. On the login page, please login through single sign-on with your Google account.
2. You can upload the Course Evaluation file from the project directory /public/uploads and press the "generate" button.
3. You can press the "Download Final Comparison" button to download the processed file.
4. You can upload multiple files, which represent data in different semesters, the name of such file looks like "Individual_1_FA22.xlsx".
5. You can press "Generate Comparison" and press "Download Final Comparison" button to download the processed file.
6. You can press "Back to Homepage" to redirect to Homepage and upload the files again.
7. You can click the "Profile" button on the left-top corner to see your login name and logout your account.


