![dbt CI](https://github.com/Goku007007/dbt-duckdb-incremental-starter/actions/workflows/dbt.yml/badge.svg)

# dbt + DuckDB Incremental Starter

Tiny dbt + DuckDB project: **seeds → staged model with tests → incremental fact** that only loads new rows. Clone-and-run.

## What this shows (micro-proof)
- **Seeds** create `main_raw.orders` / `main_raw.customers`
- **Staging model** `stg_orders` with **tests**: `not_null`, `unique`
- **Incremental fact** `fct_orders_incremental` using `_loaded_at` watermark
- Fully **local** (DuckDB) — no cloud creds needed

**Stack:** SQL, dbt, DuckDB

---

## Quickstart
# -> Clone
git clone https://github.com/Goku007007/dbt-duckdb-incremental-starter.git
cd dbt-duckdb-incremental-starter

# -> dbt profile (update the path inside the file to your machine)
mkdir -p ~/.dbt
cp profiles_example.yml ~/.dbt/profiles.yml

# -> Environment & install
python3 -m venv .venv && source .venv/bin/activate
pip install dbt-core dbt-duckdb duckdb

# -> Run it
dbt seed
dbt run -s stg_orders
dbt test -s stg_orders
dbt build -s fct_orders_incremental

# Append a brand-new row with a later _loaded_at
printf "\n7,50,2025-01-07,55.00,2025-01-07 11:00:00" >> seeds/orders.csv

# Reload seeds and rebuild only the incremental model
dbt seed
dbt build -s fct_orders_incremental

Tests PASS for stg_orders
<img width="679" height="90" alt="Screenshot 2025-08-14 at 12 54 37 PM" src="https://github.com/user-attachments/assets/f4cbfadc-6d74-4622-a38e-6f96cd7deea0" />

Build of fct_orders_incremental
<img width="666" height="36" alt="Screenshot 2025-08-14 at 12 55 08 PM" src="https://github.com/user-attachments/assets/fd85eba3-eee9-4a6c-81a8-dab8e092297b" />
