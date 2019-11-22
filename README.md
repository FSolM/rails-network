# Rail's Network
### A social media project using Rails
#### Project 8

**Live version:** https://ca-fs-application.herokuapp.com

You can check the ERD model over [**here**](./docs/ERD.md)

## Usage & Installation

Install the necessary gems:

```
$ bundle install --without production
```

*The gems included in the project are no necessary up to date, be sure to update them before running the project to project it from vulnerabilities.*

**Configure the database for both development & testing:**

***Using bash:***

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

***Without using bash***

1. Go to the file `config/database.yml` and manually config the enviorment variables acording to your preference

#### Created by:

Carlos Sol: [@FSolM](https://github.com/FSolM)<br>
Juan Escobar: [@codingAngarita](https://github.com/codingAngarita)
