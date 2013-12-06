# Rack Usermanual

![Build status](https://travis-ci.org/chrismdp/rack-usermanual.png) &nbsp; ![Code climate](https://codeclimate.com/github/chrismdp/rack-usermanual.png)

Want to embed your cucumber features directly into your project as a User manual? Here's a gem to do it.

See an example here: [http://soltrader-online.herokuapp.com/help/game-manual/combat](http://soltrader-online.herokuapp.com/help/game-manual/combat)

## Installation

```
gem install rack-usermanual
```

(or add it to your bundle.)

## Usage


### Rack

To use, add the following to your Rack::Builder instance:

```
# Choose whatever url endpoint you like.
map "/help" do
  use Rack::Usermanual,
    :sections => {
      "Game manual" => 'features/docs/game-manual',
      "API documentation" => 'features/docs/api-documentation'
    },
    :index => 'features/docs/README.md'
end
```

### Rails

Inside your `config/routes.rb`:

```
  mount Rack::Usermanual.new(nil, :index => 'README.rdoc', :sections => ...), :at => '/help'
```

(I'm not quite sure about the best way to pass options with rails - clarifications welcome!)

Then start your app and point your browser to `/help` and your features should be displayed for you.

### Options

These are the options you can pass to the app:

  * `sections`: Sections of the manual: human readable name together with a path to a folder containing the features.
  * `index`: Markdown file to display on the index page of the help. Required.
  * `layout`: the path from the root of your app to the layout you want to use. Uses `views/layout.haml` as the default.

## Caveats

The app will use the layout that you have given, but for Rails you might need to provide a custom layout as rails helpers such as `stylesheet_link_tag` currently don't work (Pull requests welcome!)

The CSS in the views is based on bootstrap: you might need to provide style your features slightly differently to get them to work in the way that you want. If you need more CSS classes, do submit pull requests to get them.

## Contributing

We work on pull requests. If you have an idea for something you'd like to contribute, here's how to do it:

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.
