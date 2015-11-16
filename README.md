##Dead Simple Multi-Process Implementation Using Sidekiq

---

This is just a demo of calling a method from a main ruby object `main.rb` and
having it pass this off as a job to a redis db where sidekiq `worker.rb` will
pick it up asyncrhonously. This is a useful technique for dealing with any
process that depends on communication with an outside service that is slow and
therefore will tie up your main process which may be trying to load a page or in
my case monitor a file server for changes that at times can be high traffic.

To try out, clone this repo and bundle install:

```
git clone git@github.com:JSalig1/multithread.git
bundle install
```

Install redis if you don't already have it (I use homebrew):

```
brew install redis
```

Start your redis server using CLI command:

```
redis-server
```

From the root of this repo (and in a new terminal window) start sidekiq and
point it at `main.rb`:

```
bundle exec sidekiq -r ./main.rb
```

You now have your sidekiq backend proccess which is watching redis, and you have
a redis server that is listening for any new jobs from your main process. To
simulate a main proccess we can open another terminal pane and use irb:

```ruby
irb
require './main'

process = Main.new
process.call_async
```

Do `call_async` a bunch if you like.

This adds a new job to redis which sidekiq will pick up and execute. You'll see
the results print out to the terminal window where your sidekiq is running.
Hopefully if you're using this you'll be doing all sorts of more useful things
than printing out a few numbers and a string. ;)

Useful info for getting started with sidekiq:
[sidekiq wiki](https://github.com/mperham/sidekiq/wiki)

I played around with deamonizing the sidkiq process but then I found that might
be frowned upon:

[Don’t Daemonize your Daemons!](http://www.mikeperham.com/2014/09/22/dont-daemonize-your-daemons/)

But worth noting that you can do it and then output to a log file in place of
the terminal if that's what you really really wanted to do.
