require 'gherkin'
require 'gherkin/formatter/json_formatter'
require 'stringio'
require 'json'
require 'sinatra'
require 'kramdown'

module Rack
  class Usermanual < Sinatra::Base
    VERSION = "0.1.0"

    def initialize(app, options)
      super(app)
      @sections = options[:sections]
      @index = options[:index]
      @main_views = options[:views]
    end

    helpers do
      def find_template(views, name, engine, &block)
        new_views = [
          ::File.expand_path(::File.join(::File.dirname(__FILE__), '..', '..', '..', 'views')),
          @main_views
        ].flatten.compact
        Array(new_views).each { |v| super(v, name, engine, &block) }
      end

      def h(text)
        Rack::Utils.escape_html(text)
      end

      def humanize(word)
        word.capitalize.gsub(/[-_]/, ' ')
      end

      def replace_start(sentence)
        {
          /^given / => 'Assume ',
          /^but / => 'However, ',
          /^and / => ''
        }.each do |find, replace|
          sentence.sub!(find, replace)
        end
        sentence
      end
    end

    get '/?' do
      haml :index
    end

    def get_feature(path, page)
      sio = StringIO.new
      json_formatter = Gherkin::Formatter::JSONFormatter.new(sio)
      parser = Gherkin::Parser::Parser.new(json_formatter)
      filepath = "#{path}/#{page}.feature"
      halt 404 unless ::File.exist?(filepath)
      raw = ::File.read(filepath)
      parser.parse(raw, uri, 0)
      json_formatter.done
      [raw, JSON.parse(sio.string)]
    end

    get %r{/([\w-]+)/([\w-]+)/?$} do
      section_uri, @page = params[:captures]

      section = @sections.select do |human_name, path|
        ::File.basename(path) == section_uri
      end
      halt 404 unless section
      @human_name = section.keys.first
      path = section.values.first

      @raw, @json = get_feature(path, @page)

      haml :page
    end
  end
end
