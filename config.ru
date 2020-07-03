#! usr/bin/env ruby
require 'rack'
load 'authentication.rb'
load 'app.rb'

use Authentication, "posts" do |username, password|
	(username == 'admin') && (password == '8594@Lai')
end

run App.new