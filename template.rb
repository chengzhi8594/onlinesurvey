DATA_PATH = ENV['DB_ENV'] || "./data/data.json"
class Template
	def initialize(page)
		@page = page
		file = File.join(File.dirname(__FILE__), "./templates/#{page}.html.erb")
		@template = File.read(file)
	end

	def count(str)
		i = 0
		File.open(DATA_PATH).each do |line|
			i += line.gsub(str).count
		end
		i
	end
	
	def total_survey_count
		a = 0
		File.open(DATA_PATH).each do |line|
			a += 1
		end
		a
	end

	def render
		ERB.new(@template).result(binding)
	end
end
