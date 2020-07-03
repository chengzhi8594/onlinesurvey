require 'test/unit'
require_relative '../template'
DATA_PATH = "./data/test.json"

class TemplateTest < Test::Unit::TestCase
	def test_survey_template
		template = Template.new(:survey)
		assert_not_nil template, "survey template is nil"
	end
	def test_admin_template
		template = Template.new(:admin)
		assert_not_nil template, "admin template is nil"
	end
	def test_total_survey_count
		template = Template.new(:admin)
		survey_count = template.total_survey_count
		assert_equal 9, survey_count, "survey count should return 9"
	end
end
