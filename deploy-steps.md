https://github.com/supabase/pg_graphql/blob/ae71021f5971bec7100578baba1b0491ed667e78/.github/workflows/release.yml

1. make sure pg14 is installed on the system and is first in the path
2. `cargo install cargo-pgx --version 0.6.0-alpha.1 --locked`
3. dev & test changes with `cargo pgx run pg14`
4. change package.version in Cargo.toml to be after the current version (E.G. add `-alpha.1` to the end)
5. `cargo pgx package --no-default-features --features pg14`
6. `./target/release/pg_graphql-pg14` has the folder structure ready to copy into the server
7. `drop extension pg_graphql cascade; create extension pg_graphql cascade;`
