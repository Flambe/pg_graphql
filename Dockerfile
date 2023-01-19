FROM ubuntu:20.04

RUN apt-get update && apt-get install -y lsb-release gnupg2 wget && apt-get clean all
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN  wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | tee /etc/apt/trusted.gpg.d/pgdg.asc &>/dev/null
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7FCC7D46ACCC4CF8
RUN  apt-get update
RUN  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends git build-essential libpq-dev curl libreadline6-dev zlib1g-dev pkg-config cmake \
        libreadline-dev zlib1g-dev flex bison libxml2-dev libxslt-dev libssl-dev libxml2-utils xsltproc ccache \
        clang libclang-dev gcc
RUN  apt install -y postgresql-15 postgresql-server-dev-15 -y
RUN  export PATH=$PATH:/usr/lib/postgresql/15/bin
RUN useradd -ms /bin/bash build
COPY . /home/build
RUN chown build:build -R /home/build
USER build
WORKDIR /home/build
RUN  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path --profile minimal --default-toolchain nightly

# exec into the container and run these:
# source "$HOME/.cargo/env"
# cargo install cargo-pgx --version 0.6.1 --locked # (make sure the version here matches the one in Cargo.toml)
# cargo pgx init --pg15=/usr/lib/postgresql/15/bin/pg_config
# cargo pgx package --no-default-features --features pg15
# cd target/release/pg_graphql-pg15
# tar cf pg_graphql.tar usr

# docker cp the tar out to your system and you can then extract it in your pg server & recreate the extension
# if running via postgrest is still not working, restart postgrest
