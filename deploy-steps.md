https://github.com/supabase/pg_graphql/blob/ae71021f5971bec7100578baba1b0491ed667e78/.github/workflows/release.yml


1. change package.version in Cargo.toml to be after the current version (E.G. add `-alpha.1` to the end)
2. `docker build .`
3. follow steps inside `Dockerfile`
4. copy the file you `docker cp`'d out into your server and extract it
5. `drop extension pg_graphql cascade; create extension pg_graphql cascade;`
6. restart stack if postgrest is being silly
