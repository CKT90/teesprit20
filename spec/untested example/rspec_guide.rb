# site reference 
# https://relishapp.com/rspec

# Stub - fake implementation of a method
# Mock - fake implementation of an object
# Double - a newer term to represent an object that stands in for another object

# run before run rspec, else will have bundling gem error
bin/rake db:migrate RAILS_ENV=test

# Rspec will ignore file test without '_spec'


before(:example) # run before each example
before(:context) # run one time only, before all of the examples in a group

after(:example) # run after each example
after(:context) # run one time only, after all of the examples in a group


#TEST--------------------------------------------------------------------------------
require "rspec/expectations"

class Thing
  def widgets
    @widgets ||= []
  end
end

RSpec.describe Thing do
  before(:example) do
    @thing = Thing.new
  end

  describe "initialized in before(:example)" do
    it "has 0 widgets" do
      expect(@thing.widgets.count).to eq(0)
    end

    it "can accept new widgets" do
      @thing.widgets << Object.new
    end

    it "does not share state across examples" do
      expect(@thing.widgets.count).to eq(0)
    end
  end
end

#all pass, before(:example) runs in each example so the third method is valid

#TEST--------------------------------------------------------------------------------
require "rspec/expectations"

class Thing
  def widgets
    @widgets ||= []
  end
end

RSpec.describe Thing do
  before(:context) do
    @thing = Thing.new
  end

  describe "initialized in before(:context)" do
    it "has 0 widgets" do
      expect(@thing.widgets.count).to eq(0)
    end

    it "can accept new widgets" do
      @thing.widgets << Object.new
    end

    it "shares state across examples" do
      expect(@thing.widgets.count).to eq(1)
    end
  end
end

#all pass, before(:context) runs once, so each method used same @widgets




#BUILT-IN EXPECTATION--------------------------------------------------------------------------------

#EQUIVALENCE TEST
expect(actual).to eql(expected)   # passes if actual.eql?(expected)
expect(actual).to equal(expected) # passes if actual.equal?(expected)
# NOTE: `expect` does not support `==` matcher.

#COMPARISON TEST
expect(actual).to be >  expected
expect(actual).to be >= expected
expect(actual).to be <= expected
expect(actual).to be <  expected
expect(actual).to be_between(minimum, maximum).inclusive
expect(actual).to be_between(minimum, maximum).exclusive
expect(actual).to match(/expression/)
expect(actual).to be_within(delta).of(expected)
expect(actual).to start_with expected
expect(actual).to end_with expected
# NOTE: `expect` does not support `=~` matcher.

#TRUTH TEST
expect(actual).to be_truthy    # passes if actual is truthy (not nil or false)
expect(actual).to be true      # passes if actual == true
expect(actual).to be_falsey    # passes if actual is falsy (nil or false)
expect(actual).to be false     # passes if actual == false
expect(actual).to be_nil       # passes if actual is nil
expect(actual).to exist        # passes if actual.exist? and/or actual.exists? are truthy
expect(actual).to exist(*args) # passes if actual.exist?(*args) and/or actual.exists?(*args) are truthy

#TYPE/CLASSES.RESPONSE
expect(actual).to be_instance_of(expected)
expect(actual).to be_kind_of(expected)
expect(actual).to respond_to(expected)

#Error
expect { ... }.to raise_error
expect { ... }.to raise_error(ErrorClass)
expect { ... }.to raise_error("message")
expect { ... }.to raise_error(ErrorClass, "message")


#FRAMEWORK--------------------------------------------------------------------------------

#FRAMEWORK
RSpec.describe "something" do

  it "something" do
  end

  context "name cannot save" do
    it "if already existed elsewhere" do
    end

    it "if exceeded 10 character" do
    end

    example "something..."
    specify "something..."

  end


end


#COMMAND------------------------------------------------------------------------------

rspec                 
#run rpsec test

rspec —only-failures
#To use `—only-failures`, you must first set `config.example_status_persistence_file_path`



#Shared Example-----------------------------------------------------------------------

RSpec.shared_examples 'shared example' do |my_parameter|
  let(:kv_store) { my_parameter.new }
  
  it 'allows you to fetch previously stored values' do 
    kv_store.store(:language, 'Ruby') 
    kv_store.store(:os, 'linux')

    expect(kv_store.fetch(:language)).to eq 'Ruby' 
    expect(kv_store.fetch(:os)).to eq 'linux'
  end

  it 'raises a KeyError when you fetch an unknown key' do 
    expect { kv_store.fetch(:foo) }.to raise_error(KeyError)
  end 
end

#application
require 'hash_kv_store' 
require 'support/kv_store_shared_examples'

# note the usage of 'it_behaves_like'
RSpec.describe HashKVStore do 
  it_behaves_like 'shared example', insert_parameter 
end

# note the usage of 'include_examples'
RSpec.describe HashKVStore do 
  include_examples 'shared example', insert_parameter
end


# differentiation
# note the usage of 'it_behaves_like'
RSpec.describe HashKVStore do 
  it_behaves_like 'shared example', insert_parameter_1
  it_behaves_like 'shared example', insert_parameter_2
end

#generates
  context 1
    message spec 1
    message spec 1
  context 2
    message spec 2
    message spec 2

# note the usage of 'include_examples'
RSpec.describe HashKVStore do 
  include_examples 'shared example', insert_parameter_1
  include_examples 'shared example', insert_parameter_2
end

#generates
  context 2
    message spec 1
    message spec 1
    message spec 2
    message spec 2

# therefore only use 'include_examples' when very sure won't conflict, for readability


# Shared Example --------------------------------------------------------------------------------

# shared groups with blocks 

RSpec.shared_examples 'shared example' do #|my_parameter|
  #let(:kv_store) { my_parameter.new } ### REMOVED
  
  it 'allows you to fetch previously stored values' do 
    kv_store.store(:language, 'Ruby') 
    kv_store.store(:os, 'linux')

    expect(kv_store.fetch(:language)).to eq 'Ruby' 
    expect(kv_store.fetch(:os)).to eq 'linux'
  end

  it 'raises a KeyError when you fetch an unknown key' do 
    expect { kv_store.fetch(:foo) }.to raise_error(KeyError)
  end 
end



RSpec.describe FileKVStore do 
  it_behaves_like 'KV store' do 
    let(:kv_store) { FileKVStore.new(tempfile.path) } #define 'kv_store' here
end end


# Metadata--------------------------------------------------------------------------------

# setting all tagged with  'type:model' to have fast: true metadata
RSpec.configure do |config| 
  config.define_derived_metadata(type: :model) do |meta|
    meta[:fast] = true
    meta[:aggregate_failures] = true unless meta.key?(:aggregate_failures) # can be set off from example by including 'aggregate_failures: false'
  end 
end

#Using Helper for test---------------------------------------------------------------------

RSpec.describe BerlinTransitTicket do 

  def fare_for(starting_station, ending_station) #Helper method to DRY
    ticket = BerlinTransitTicket.new 
    ticket.starting_station = starting_station 
    ticket.ending_station = ending_station 
    ticket.fare
  end

  context 'when starting in zone A and ending in zone B' do 
    it 'costs €2.70' do 
      expect(fare_for('Bundestag', 'Leopoldplatz')).to eq 2.7
    end 
  end

  context 'when starting in zone A and ending in zone C' do 
    it 'costs €3.30' do 
      expect(fare_for('Bundestag', 'Birkenwerder')).to eq 3.3
    end 
  end 
end


#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
#TEST--------------------------------------------------------------------------------
