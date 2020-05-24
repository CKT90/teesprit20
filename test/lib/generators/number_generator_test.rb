require 'test_helper'
require 'generators/number/number_generator'

class NumberGeneratorTest < Rails::Generators::TestCase
  tests NumberGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
