# Carmen

## Walkthrough / Smoke Test

These instructions are based on the [Docker's official Rails sample application](https://docs.docker.com/compose/rails/).

1. Install [Docker](https://www.docker.com/products/docker-desktop)
2. Install [docker-sync](http://docker-sync.io/) using `gem install docker-sync`
3. Ensure all `.localhost` domains are [pointing at the localhost](https://passingcuriosity.com/2013/dnsmasq-dev-osx/)
4. Build the initial images and containers using `docker-compose build`
5. Create the database using `docker-compose run web rake db:create`
6. Create `.env.development.local` file and populate with relevant environment variables (check `.env` for what you need)
7. Start the app using `docker-sync-stack start`
8. Access the app by visiting <https://carmen.localhost/>

You should be able to stop the app running with `Ctrl +C`, but if you want to fully stop all containers and shut everything down, use `docker-sync-stack clean`

### docker-sync

docker-sync is a tool which speeds up development, but it's not without it's complexity, which is why it is important to understand how it works.

Essentially, docker-sync creates an shared volume (defined in the `docker-compose-dev.yml` file) and uses this to sync files between the host machine and the docker containers. But because of this additional config, extra steps need to be taken to ensure it's included when running the app.

When you run the `docker-sync-stack start` command listed above, the first thing it does is create the shared volume then runs `docker-compose` within the context of this additional config, for example:

```bash
docker-sync start
docker-compose -f docker-compose.yml -f docker-compose-dev.yml up
```

With this in mind, if you need to do anything such as installing or updating gems, running migrations, or especially anything which generates new files to be committed to the repo, make sure the app is running, then execute it within the same context - for example, to run `bundle install`, use the following:

```bash
docker-compose -f docker-compose.yml -f docker-compose-dev.yml exec web bundle install
```

Thankfully, you can use the `docker/sync` script to bypass much of this boilerplate, letting you replace the above line with:

```bash
./docker/sync exec web bundle install
```

Equally important is the ability to clear away and refresh everything, such as after a change to the Docker configuration or a change to the `Gemfile`, or simply because you're done for the day. To do this, simply run `docker-sync-stack clean`

## SSL server

To better match production, the development environment has been configured to use SSL.

Rails has been set to `force_ssl`, which means it will automatically redirects non-https requests to the https counterpart.

To facilitate this, a TCP Rails server is configured to run on port `3001` (for the sole purpose of redirection, as a convenience more so than anything else), with the Rails SSL counterpart running on `3000`. Accordingly, port `80` is forwarded to port `3001`, and port `443` to port `3000`.

The SSL certificate used is self-signed, meaning your browser will complain about it being insecure, but simply accepting the warning dialog will fix this issue.

### Hints and tips

- The postgres database port `5432` is exposed on `localhost`, allowing you to connect via a local tool.
- The data for the database is stored in `tmp/db` - if you need a fresh start for any reason, you can simply destroy the db container, and delete this directory.
- Mailcatcher is used as a local mail capture service, which can be accessed via <http://localhost:1080/>

## Testing

The tests are powered by rspec, and can be run using:

```bash
./docker/sync exec web bundle exec rspec
```

The app also features a [Guard](https://github.com/guard/guard) configuration file, allowing for automatic browser updating via [livereload](http://livereload.com/), and automatic rspec runs on changed files.

The output for rspec can be viewed in the output of the running `guard` container.
