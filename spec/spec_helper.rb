require 'sinatra'

Sinatra::Application.environment = :test
Bundler.require :default, :test

require_relative '../lib/rack-usermanual'

