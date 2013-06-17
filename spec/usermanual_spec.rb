require 'spec_helper'
require 'rack/test'

describe Rack::Usermanual do
  include Rack::Test::Methods

  def app
    Rack::Usermanual.new(nil, :sections => {'My section' => 'spec/fixtures/features/my-section'})
  end

  it "grabs a file from the features folder" do
    get '/help/my-section/test'
    last_response.should be_ok
    last_response.body.should include("This is the preamble")
  end

  it "accepts trailing slashes" do
    get '/help/my-section/test/'
    last_response.should be_ok
    last_response.body.should include("This is the preamble")
  end

  it "formats that file correctly" do
    get '/help/my-section/test'
    last_response.body.should include("Assume something is true")
  end

  it "does not allow you to get a random filesystem file" do
    get '/help/../../lib/solweb.rb'
    last_response.should_not be_ok
    get '/help/../docs/game-manual/combat.feature'
    last_response.should_not be_ok
  end

  it "returns 404 if the file doesn't exist" do
    get '/help/game-manual/cimbat'
    last_response.should_not be_ok
  end
end
