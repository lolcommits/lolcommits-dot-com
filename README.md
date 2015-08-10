## Jahbs

"At least we've got one" ~ Anonymous

This project is a fork of lolcommits-dot-com. It's a small Rails application
which talks to the Github API for user authentication and displays a series of
galleries taken of me while committing code at work. Work being a computer and
not really an actual time and place.

Photos, static or animated, may be viewed [here](http://jahbs.0p9.co) in all the
their glory.

>
> ==== Development
>
> Some initial set up is involved after cloning this repository. First configure
> your local postgresql connection in config/database.yml
>
>     cp config/database.example.yml config/database.yml
>
> Setup initial env variables
>
>     cp .env.example .env
>
> Install dependencies
>
>     bundle install
>     bundle exec rake db:migrate
>
> Run the web server at http://localhost:3000;
>
>    bundle exec foreman start
>
> To run the test suite;
>
>     bundle exec rake
>
> ==== GitHub OAuth
>
> If you want to have Git OAuth work locally, you should create a new application
> at GitHub for local development;
>
> Visit https://github.com/settings/application create a new app and make sure to
> set the following;
>
>     Homepage URL: http://localhost:3000
>     Authorization callback URL: http://localhost:3000/auth/github/callback
>
> Then paste your new GitHub application key and secret to app's the local `.env`
> file.
