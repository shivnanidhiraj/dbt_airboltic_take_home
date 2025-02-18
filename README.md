# dbt Airboltic Take-Home Project
Please refer to Google doc for details.

## Overview

- **Staging Models**: Clean and prepare raw data from our source tables.
- **Dimension Models**: Build surrogate key dimensions:
  - **dim_customers**: Enriches customer data by joining with customer group information.
  - **dim_aeroplane**: Combines raw airplane data with additional specifications from our JSON-based seed.
  - **dim_trip**: Captures trip details like origin, destination, and flight duration.
- **Fact Model**: **fact_orders** stores the transactional data (orders/seat booking) and links to the dimensions.
- **Testing & Documentation**: Built-in dbt tests and documentation help maintain data quality and provide lineage and model insights.

## Project Structure

```plaintext
.
├── dbt_project.yml
├── macros
│   └── surrogate_key.sql
├── models
│   ├── dimension
│   │   ├── dim_aeroplane.sql
│   │   ├── dim_customers.sql
│   │   └── dim_trip.sql
│   ├── fact
│   │   └── fact_orders.sql
│   ├── schema.yml
│   ├── sources
│   │   └── sources.yml
│   └── staging
│       ├── stg_aeroplane.sql
│       ├── stg_aeroplane_model.sql
│       ├── stg_customer_group.sql
│       ├── stg_customers.sql
│       ├── stg_order.sql
│       └── stg_trip.sql
├── seeds
│   └── aeroplane_model.csv
├── snapshots
└── tests
    ├── test_missing_fk.sql
    ├── test_no_duplicate_orders.sql
    └── validate_flight_duration.sql
```

## Prerequisites
 - Python 3.9+ installed
 - dbt Core installed along with the appropriate adapter (e.g., dbt-postgres if using Postgres)
 - Git installed

## Steps to Get Started
1. Clone the repo
    ```
   git clone https://github.com/yourusername/dbt_airboltic_take_home.git
   cd dbt_airboltic_take_home
   ```
2. Install Dependencies
   ```
   pip install dbt-core dbt-postgres
   ```
3. Update (or create) your ~/.dbt/profiles.yml to point to your data warehouse. For example:
  ```
  air_boltic:
    target: dev
    outputs:
      dev:
        type: postgres
        host: your_db_host
        user: your_username
        password: your_password
        port: 5432
        dbname: your_db_name
        schema: your_schema
```
4. Seed the database
   ```
   dbt seed

   ```
5. Run dbt Models
   ```
   dbt run
   ```
6. Run Tests
   ```
   dbt test
   ```
7. Generate Documentation
   ```
   dbt docs generate
   dbt docs serve
   ```
   Then open http://localhost:8080 in your browser to explore your data lineage and model docs.

------------------------------------------------------------------------------------------------------
## Running the Project
After the initial setup, you can run the following commands as you continue development:

1. To run after the changes
   ```
   dbt run
   ```
2. To run the tests
   ```
   dbt test
   ```
   
------------------------------------------------------------------------------------------------------

## Testing & Documentation
- **Schema Tests**: Defined in the _schema.yml_ file to ensure columns meet expectations (e.g., not_null, unique, relationships).
- **Data Tests**: Custom tests in the _tests/_ folder (e.g., test_missing_fk.sql, test_no_duplicate_orders.sql, validate_flight_duration.sql).
- **Documentation**: Auto-generated with dbt docs generate and served via dbt docs serve.
