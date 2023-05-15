# ExpensesTracker
## Installing Project Dependencies
* First the project requires Elixir and Erlang to run and installation can be done from [here](https://elixir-lang.org/install.html).
* Ensure Elixir is installed by running
```
$ elixir -v
```
* After installing Elixir and Erlang, install hex by running
```
$ Mix local.hex
```
* Then install the phoenix application generator by running
```
$ mix archive.install hex phx_new
```

## Starting the Project
After all dependencies are installed, I generated the new application by running:
```
$ mix phx.new expenses_tracker --database postgres --binary-id
```
Where `--database` flag is to install the database adapter for ecto for postgres.
The `--binary-id` flag is to use uuid for the database instead of bigint.

After starting the project I run a new docker container for postgres database by running:
```
$ docker run --name <database_name> -e POSTGRES_USER=<username> -e POSTGRES_PASSWORD=<password> -p 5500:5432 -d postgres
```
This started a new docker postgres container where I could use as the database with the port set to 5500 to avoid any conflicts which I configured in the config/dev.exs file by adding `port: "5500"`.
After database is configured I run `mix deps.get` to install all the dependencies of the project.
After all dependencies are installed I run `mix ecto.create` to create the new database inside the postgres container.
To double check in the postgres container that the database was succesfully created, One would run:
```
$ psql -U <username> <password> <database_name>
```
After all was done I run `mix phx.server` to start the server and check if everything was running.

## REST API creation
After successfully creating the database and project, it was time now to develop the REST API.
It was time to create the two tables I came up with for the project, that is the `expenses` table as well as the `expense_types` table.
To generate the JSON API for managing expense types I run:
```
$ mix phx.gen.json ExpenseTypes ExpenseType expense_types name:string
```
Where this created a migration, a schema, a controller, and some tests for the ExpenseType resource.
To migrate the data I run `mix ecto.migrate`.

The same was done for the expenses table but with a little addition i.e.:
```
$ mix phx.gen.json Expenses Expense expenses expense_type_id:references:expense_types amount:integer paid_to:string
```
The `expense_type_id` was set as a foreign key to the expenses table. This was to link the expenses and the expense types.
I also migrated the data by running `mix ecto.migrate`.

After I defined the associations between the expense types and expenses by adding `belongs_to` clause in the `expense.ex` file as well as adding `has_many` clause in the `expense_type.ex` file.

## Setting up the routes
After all that was done it was time to set up the routes in the `router.ex` file for the API and these routes can be tested by a HTTP client service such as Postman.

The requests are set as follows:
* `GET /api/expense_types` to list all expense types
* `POST /api/expense_types` to create a new expense type
* `GET /api/expenses` to list all expenses
* `POST /api/expenses` to create a new expense

The Expense Tracker application is now complete.
