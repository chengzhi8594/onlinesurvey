require 'rack'
require 'cgi'
require 'json'
require_relative 'template'
require_relative 'router'
class App
	def call(env)
		response_headers = {}
		request_cookies = Rack::Utils.parse_cookies(env)
		puts(env["PATH_INFO"])
		route = Route.new(env)
		status = route.name =~ /^\d\d\d$/ ? route.name.to_i : 200
		if request_cookies["sent_survey"] && env["PATH_INFO"] == "/" then
			env["PATH_INFO"] = "/thank_you"
			route = Route.new(env)
		elsif env["REQUEST_METHOD"] == "POST"
			params = CGI::parse(env["rack.input"].read)
			puts(params)
			puts(params["email"][0])
			email = params["email"][0] || ""
			email_inuse = nil
			File.open(DATA_PATH).each do |line|
				email_inuse = email_inuse || line.downcase.include?(email.downcase)
			end
			if email_inuse then
				env["PATH_INFO"] = "/mail_used"
			else
				env["PATH_INFO"] = "/thank_you"
				File.open(DATA_PATH,"a") do |line|
				line.puts(params.to_json)
			end
			end
			route = Route.new(env)
			puts(env["PATH_INFO"])
			Rack::Utils.set_cookie_header!(response_headers, "sent_survey", true)
		end
		template = Template.new(route.name)

		[status, response_headers, [template.render]]
	end
end
