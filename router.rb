require 'uri'

class Route
	Routes = {
		"GET" => {
			"/" => :survey,
			"/thank_you" => :thank_you,
			"/admin" => :admin
		},
		"POST" => {
			"/new_article" => :user_article,
			"/thank_you" => :thank_you,
			"/mail_used" => :mail_used
		}
	}

	def initialize(env)
		http_method = env["REQUEST_METHOD"]
		path = env["PATH_INFO"]
		@name = Routes[http_method] && Routes[http_method][path]
end

	def name
		@name || "404"
	end
end
