require "rails_helper"

RSpec.describe Product, :type => :model do

  let!(:ot_1) { create :ot_1 } #by using 'bang', i do not need to mention :ot in every example to ignite cache. with bang, it will initiate same to all example
  let!(:ot_2) { create :ot_2 } #by using 'bang', i do not need to mention :ot in every example to ignite cache. with bang, it will initiate same to all example
  let(:pass) { create :product_1, option_type_ids: [1]} 
  let(:prod) { create :product_1, option_type_ids: [1,2]}
  let(:fail) { build :product_2} # use build instead of create, so no need to save and go through validation. it can let you create an invalid saved database item on purpose to test validity
  #build will replicate factory 100%. cannot be change though unlike create [untested]
  

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:option_types) }

  it "save with option types" do
  	expect(pass.save).to eq(true)
  end

  it "must not save without option types" do
  	expect(fail.save).to eq(false)
  end

  it "ot_1 have 2 option values" do
  	expect(ot_1.option_values.count).to eq(2)
  end

  it "product variants count equal to option type count of option value multiply by each other, in this case 8" do
  	expect(prod.variants.count).to eq(8)
  end

  it "option type is valid" do
  	expect(ot_1.valid?).to eq(true)
  end
end