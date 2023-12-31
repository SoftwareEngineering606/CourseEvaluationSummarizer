# CourseEvaluationSummarizerProject
---------------------------------------------------------------------------------------------------------------------------
Heroku deployed App link:
https://peaceful-earth-44851-8eb808894c2b.herokuapp.com/

## First: Contact information

Kangdong Yuan
kky5082@tamu.edu
8148528757

Pratik Desai
+1-979-350-0973

Vinodheni Ramasrinivasan
+1-979-721-2361

Prathyusha Polepalli
+1-979-344-3684

### Important information, if you have any problem with environment setup, app running, or deployment. Please text or call me.
---------------------------------------------------------------------------------------------------------------------------
## Second: Installation and Setup guide

### Clone the repository

Please visit https://github.com/SoftwareEngineering606/CourseEvaluationSummarizer to clone our project. 
- Command to clone :
``` 
git clone git@github.com:SoftwareEngineering606/CourseEvaluationSummarizer.git
```

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
   
## Postgres Installation for Windows

1. Download and Install PostgreSQL: https://www.postgresql.org/download/windows/ 
   Visit the official PostgreSQL download page: PostgreSQL Downloads
   Download the latest version for Windows.
   Run the installer and follow the installation wizard. Make sure to remember the password you set for the postgres user.

   Download PostgreSQL:

1. Visit the official PostgreSQL download page: https://www.postgresql.org/download/windows/ 
   Choose the version that suits your needs and click on the installer link.
   
3. Run the Installer:
   Execute the downloaded installer to start the installation process.
   
4. Choose Installation Directory:
   During installation, you will be prompted to choose an installation directory. You can choose the default or specify a custom location.
   
5. Select Components:
   Select the components you want to install. The default components are usually sufficient for most users.
  
6. Set Data Directory:
   Choose a location for the data directory. This is where PostgreSQL will store its data. Again, the default location is usually fine.

7. Enter Password for Superuser:
   Set a password for the superuser (postgres). Remember this password as you'll need it later.

8. Specify Port:
   Choose the port on which PostgreSQL will listen. The default is 5432, and you can usually stick with this unless you have a specific reason to change it.

9. Select Locale:
   Choose the default locale settings. The default values are usually appropriate for most users.

10. Install Stack Builder:
   Stack Builder is a tool that allows you to download and install additional tools and drivers for PostgreSQL. You can choose whether to install it or not.

11. Complete the Installation:
   Complete the installation process by clicking through the remaining steps.

12. Add PostgreSQL to the System Path:
   During the installation, you might be asked if you want to add PostgreSQL to the system path. It's generally a good idea to do this to make it easier to run PostgreSQL commands from the command line.

13. Launch pgAdmin:
   Once the installation is complete, you can launch pgAdmin, the PostgreSQL GUI administration tool that is typically installed along with PostgreSQL.

14. Connect to the PostgreSQL Server:
   In pgAdmin, you'll need to connect to the PostgreSQL server. Use the superuser (postgres) and the password you set during installation.

Set environment variable using terminal
'''
set DB_USERNAME=your_username
set DB_PASSWORD=your_password
'''

## Postgres Installation for Ubuntu
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

If you using Linux, you may need to create the superuser for Postgresql, run the following command, substitute the highlighted word with your Ubuntu 20.04 username:
```
sudo -u postgres createuser -s Yourusername -P
```
Since you specified the -P flag, you will be prompted to enter a password for your new role. Enter your desired password, making sure to record it so that you can use it in a configuration file in a later step.

4.	Install dependencies again:
```
bundle install
```

## Postgres Installation for MAC

```
brew install postgresql@14
```

1. Start Postgres 
```
brew services start PostgreSQL
```

2. Open psql
```
psql postgres
```

3. Create a new superuser
```
CREATE ROLE newuser WITH LOGIN PASSWORD 'your_password' SUPERUSER;
```

4. To verify
```
\du
```

5. Quit psql
```
\q
```

6. Finally run this with postgres username and password
```
export DB_USERNAME=your_username
export DB_PASSWORD=your_password
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

### Running RSpec Tests
Run the following command to execute the RSpec tests:

```
bundle exec rspec
```
RSpec will run all the test files and display the test results in the terminal.


Run the following command to execute the Cucumber tests:

```
bundle exec cucumber
```

Cucumber will run all the feature files and display the test results in the terminal.

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

You can use "git status" and commit changes using "git add ." and "git commit -m yourmessage"

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
git push heroku main
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
2. You can upload multiple files, which represent data in different semesters, the name of the file should look like "*_FAxx.xlsx" or "*_SPxx.xlsx" (xx is a number that represents year) Eg: Individual_FA22.xlsx.
3. You can find the sample files under the project directory /public/uploads.
4. Press the "Generate" button which takes you to the next page. This would have generated intermediate files.
5. You can press "Generate Comparison" and then press "Download Final Comparison" button to download the final comparison file.
6. You can press "Back to Homepage" to redirect to Homepage and upload the files again.
7. You can click the "Profile" button on the left-top corner to see your login name and logout your account.


