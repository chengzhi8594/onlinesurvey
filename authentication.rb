class Authentication < Rack::Auth::Basic
	def call(env)
		if env['PATH_INFO'] == "/admin"
			super
		else
			@app.call(env)
		end
	end
end