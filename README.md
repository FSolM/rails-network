# Project: Facebook clone

This project is the final project of the Main Ruby on Rails curriculum at [Microverse](https://www.microverse.org/)

More info about the ERD [here](./docs/ERD.md)

#### [Assignment link](https://www.theodinproject.com/courses/ruby-on-rails/lessons/final-project)  

# How to setup the project
First install all the required gems

`$ bundler install`

##To config the Database (for development and tests):

#### Using bash:
1. Setup a file `.bashrc` in the root path
2. Inside the file put all the config variables that match your local postgresql role and database
```bash 
# Dev Exports

export DATABASE="database_name"
export DATABASE_USERNAME="database_username"
export DATABASE_PASSWORD="database_password"
export DATABASE_HOST="database_host"
export DATABASE_PORT=5432

# Test Exports

export TEST_DATABASE="database_name"
export TEST_USERNAME="database_username"
export TEST_PASSWORD="database_password"
export TEST_HOST="database_host"
export TEST_PORT=5432
```
#### Without using bash
1. Go to the file `config/database.yml` and manually config the enviorment variables acording to your preference
#### Authors

* [@FSolM](https://github.com/https://github.com/FSolM)
* [@codingAngarita](https://github.com/codingAngarita)