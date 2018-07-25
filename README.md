# Example Data Warehouse Project

This is an example [__dbt__](https://www.getdbt.com/) project for data warehouse project.

## Quickstart

1. Install [dbt](https://docs.getdbt.com/docs/installation)
2. Clone repo
3. Create a profile file with connections to your Snowflake or Redshift instance in `~/.dbt/profiles.yml`. Make sure to create both production `prod` and development `dev` sections for your database (Redshift, Snowflake or BigQuery) and set the default target to `dev`, following these [instructions](https://docs.getdbt.com/docs/configure-your-profile)

For example:
```
my-profile:
    outputs:
        prod:
            type: snowflake
            threads: 8
            account: myaccount
            user: dbt_user
            password: mypassword
            role: dbt_role
            database: dw
            warehouse: dbt
            schema: dt

        dev:
            type: snowflake
            threads: 8
            account: myaccount
            user: dbt_user
            password: mypassword
            role: dbt_role
            database: my_personal_dev_db
            warehouse: dbt
            schema: dt

        target: dev
```
4. To run:
    - `dbt run` <-- runs in default target (should be set to dev)
    - `dbt run --target prod` <-- runs in prod

## Contributing

Please follow this [Git commit message style guide](https://chris.beams.io/posts/git-commit/).

All development work should be done on a dedicated branch, using short-lived feature branches. When development of a new table / report is ready, submit a pull request and request a code review from your team. Once accepted into `master`, you can use tools such as [Sinter](https://www.sinterdata.com/) to manage updating models in production.

## Conventions

### Missing Values
Fact table dimension keys with missing members should follow this convention for handling "missingness":

| Description                      | Origin | Suffix | Data Type | Default Value | Missing    | Unknown    |
|----------------------------------|--------|--------|-----------|---------------|------------|------------|
| Surrogate key (GUID)             | DW     | _key   | varchar   | MD5(-1001)    | MD5(-1002) | MD5(-1003) |
| ID (from source)                 | Source | _id    | integer   | -1001         | -1002      | -1003      |
| Alphanumeric code (from source)  | Source | _code  | varchar   | (N/A)         | (Missing)  | (Unknown)  |
| Description (short, from source) | Source | _name  | varchar   | (N/A)         | (Missing)  | (Unknown)  |
| Description (long, from source)  | Source | _desc  | varchar   | (N/A)         | (Missing)  | (Unknown)  |

Dimension tables should contain matching entries for defaults, missing and unknown members.
