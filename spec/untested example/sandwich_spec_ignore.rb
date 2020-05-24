RSpec.describe 'An ideal sandwich' do 
	Sandwich = Struct.new(:taste, :toppings)
	before { @sandwich = Sandwich.new('delicious', []) } #remove repitition in each block with //sandwich = Sandwich.new('delicious', [])
	# let(:sandwich) { Sandwich.new(‘delicious’, []) } ->  alternative for above 'before'

	#describe "something someting" do << can be wrapped with to group the whole test
	it 'is delicious' do 
		#sandwich = Sandwich.new('delicious', []) -> not needed with above struct
		taste = @sandwich.taste
		expect(taste).to eq('delicious')
	end

	it 'lets me add toppings' do 
		#sandwich = Sandwich.new('delicious', []) -> not needed with above struct
		@sandwich.toppings << 'cheese' 
		toppings = @sandwich.toppings 
		expect(toppings).not_to be_empty #not_to provide negation
	end
	#end
end