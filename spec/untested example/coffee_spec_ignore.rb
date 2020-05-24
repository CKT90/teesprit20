RSpec.configure do |config| 
	config.example_status_persistence_file_path = 'spec/examples.txt'
end 
#this is done in spec/spec_helper.rb


#TEST-------------------------------------------------------------------------------------------------------------------------------
RSpec.describe 'A cup of coffee' do
	let(:coffee) { Coffee.new }

	it 'costs $1' do 
		expect(coffee.price).to eq(1.00)
	end

	context 'with milk' do #context is alias to 'describe', normally used to refer changed object (coffee changed state with added milk below)
		before { coffee.add :milk }

		it 'is light in color' do
			# pending 'Color not implemented yet' < uncomment to not show failure since haven't modify class
			expect(coffee.color).to be(:light)
		end

		it 'is cooler than 200 degrees Fahrenheit' do
			# pending 'Temperature not implemented yet'< uncomment to not show failure since haven't modify class
			expect(coffee.temperature).to be < 200.0
		end

		it 'costs $1.25' do 
			expect(coffee.price).to eq(1.25)
		end 
	end 
end

#CLASS-------------------------------------------------------------------------------------------------------------------------------
class Coffee 
	def ingredients 
		@ingredients ||= []
	end

	def add(ingredient) 
		ingredients << ingredient
	end

	def price 
		1.00 + ingredients.size * 0.25
	end 

	def color 
		ingredients.include?(:milk) ? :light : :dark
	end

	def temperature 
		ingredients.include?(:milk) ? 190.0 : 205.0
	end
end

#-------------------------------------------------------------------------------------------------------------------------------
#$ rspec spec/unit 							# Load *_spec.rb in this dir and subdirs
#$ rspec spec/unit/specific_spec.rb 		# Load just one spec file 
#$ rspec spec/unit spec/smoke 				# Load more than one directory 
#$ rspec spec/unit spec/foo_spec.rb 		# Or mix and match files and directories

