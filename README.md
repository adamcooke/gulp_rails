# Gulp + Rails

If you've decided to shun the default Rails Asset Pipeline and use gulp, 
you may be irritated that you need to run `gulp` in the background
whenever you're developing your Rails application in order to ensure 
assets are compiled when you make requests.

![Image](http://s.adamcooke.io/14/TE1xO.png)

This gem will ensure that your gulp command is executed each time a 
request is made and thus removing the requirement to run it elsewhere.

## Directory Structure

It's recommended that you place all your gulp source files and configuration
in a directory named `frontend`. In here, you should have your Gulpfile.js,
packages.json and all other source assets.

Your compiled files should be exported to `public/stylesheets` and
`public/javascripts`.

## Gulpfile Optimisation

As we are running gulp on each request, it's important to optimise your
Gulpfile to ensure your gulp command runs as quickly as possible. The
`gulp-newer` plugin is useful and ensures that compilation only takes
place if needed.

## Installation

To get started, just add this gem to your Gemfile.

```ruby
gem 'gulp_rails', '~> 1.0'
```

If you have followed the guidance above regarding directory structure,
you don't need to do anything else. Just restart your server and you
should see that your assets are compiled automatically.

![Image](http://s.adamcooke.io/14/pWWTs.png)

## Configuration

If you need to configure your library, you can do use the following
configuration

```ruby
# Whether or not compilation should take place
GulpRails.options[:enabled]         = true
# The command to run
GulpRails.options[:command]         = 'gulp'
# The arguments to pass to the command
GulpRails.options[:args]            = ''
# The directory in which your command should be executed
GulpRails.options[:directory]       = Rails.root.join('frontend')
# Whether or not run the compilation in development only
GulpRails.options[:development_only = true
# Whether or not not raise exceptions when the compilation fails 
# (this happens when execute returns a exit status different than zero)
GulpRails.options[:hide_errors]     = false
```
