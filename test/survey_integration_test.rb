require "test/unit"
require "rack/test"
require_relative "../app"
require 'erb'

class SurveyTest < Test::Unit::TestCase
	include Rack::Test::Methods

	class << self
		def startup
			if ENV['DB_ENV'] != './data/test.json'      
				puts ENV['DB_ENV']
				puts 'Must use DB_ENV=./data/test.json to run PostTest'
				exit
			end
		end
	end

	def shutdown
	end

	def app
		builder = Rack::Builder.new
		builder.run App.new
	end
	def test_root
		get '/'
		assert last_response.ok?
	end

	def test_admin
		get '/admin'
		assert last_response.ok?
	end

	def test_foo
		get '/foo'
		assert last_response.not_found?
	end

	def test_fill_blanc_survey
		post '/'
		assert last_response.not_found?
	end

end
