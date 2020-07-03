require 'test/unit'
require_relative '../router'

class RouterTest < Test::Unit::TestCase
	def test_that_it_returns_404_for_undefined_paths
		env = {
			"PATH_INFO" => "/foo123",
			"REQUEST_METHOD" => "GET"
		}
		assert_equal "404", Route.new(env).name, "/foo should return status 404"
	end
	def test_that_root_routes_to_survey
		env = {
			"PATH_INFO" => "/",
			"REQUEST_METHOD" => "GET"
		}
		assert_equal :survey, Route.new(env).name, "/ should route to :survey"
	end
	def test_that_admin_route_working
		env = {
			"PATH_INFO" => "/admin",
			"REQUEST_METHOD" => "GET"
		}
		assert_equal :admin, Route.new(env).name, "/admin should route to :admin"
	end
end
