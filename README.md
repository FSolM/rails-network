# Rails' Network

##### Project 8

#### A social media project using Rails!

## About

This is a Rails social media project that implements all the modern utilities of social media into a Rails application using different quirks of the framework.

## Details

You can check the ERD over [here](/docs/ERD.md).

**Live Version:** [Heroku Hosting](https://ca-fs-application.herokuapp.com)

This is an old project, and the gems used may not be up to date, run the

```
$ bundle update
```

command to fix any version errors or fix them manually.

## Installation

If you want to see this project in action, clone the repository and install the bundled gems with

```
$ bundle install
```

Then, migrate the database with

```
$ rails db:migrate
```

And finally, to run the app locally, use

```
$ rails server
```

### Configuration of the Database:

#### Using bash

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

## Screenshots

![Screenshot 1](/screenshots/RailsNetwork1.png)

![Screenshot 2](/screenshots/RailsNetwork2.png)

![Screenshot 3](/screenshots/RailsNetwork3.png)

![Screenshot 4](/screenshots/RailsNetwork4.png)

## Known Issues

There are some issues with how the page behaves in some devices; also the mobile version of the page has some display issues in some of the views.

The `settings` section of the menu does not redirects to a new page.

## Planned Implementations

- Update Tejuino
- Fix Display Issues
- Improve mobile version
- Add general settings

## Contact

Carlos Sol: [@FSolM](https://github.com/FSolM)

Juan Escobar: [@codingAngarita](https://github.com/codingAngarita)
