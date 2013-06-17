Rack::Usermanual
================

![Build status](https://travis-ci.org/chrismdp/rack-usermanual.png) &nbsp; ![Code climate](https://codeclimate.com/github/chrismdp/rack-usermanual.png)

This little piece of middleware helps you expose your cucumber features in a readable 'manual-like' style for your users to consume.

To use, add the following to your Rack app:

```
# Choose whatever url endpoint you like.
map "/help" do
  use Rack::Usermanual,
    # `sections`: Sections of the manual: human readable name together
    # with a path to a folder containing the features.
    :sections => {
      "Game manual" => 'features/docs/game-manual',
      "API documentation" => 'features/docs/api-documentation'
    },
    # `index`: Markdown to display on the index page of the help.
    :index => 'features/docs/README.md',
    # `views`: Look in here for the layout: layout.erb, layout.haml etc.
    :views => File.join(Dir.pwd, 'views')
end
```

Then start your app and point your browser to `/help` and your features should be displayed for you!

The app will use the layout that you have in layout.{erb,haml} in whichever folder you specify. The CSS in the views is based on bootstrap: you might need to style your features slightly differently to get them to work in the way that you want. In the future it may be possible to completely override the views with your own.

## Contributing

We work on pull requests. If you have an idea for something you'd like to contribute, here's how to do it:

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.