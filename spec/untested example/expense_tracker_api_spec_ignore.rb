# expense_tracker_api_spec.rb

require 'rack/test'
require 'json'
require_relative '../../app/api' #to include api.rb, assuming it is from different directory

##include in all Rspec
# RSpec.configure do |config|
# 	config.include_context 'API helpers'
# end

RSpec.shared_context 'API helpers' do  #seperate module for inclusion
	include Rack::Test::Methods  # using gem 'rack-test', '0.7.0', can use 'post'

	def app 
		ExpenseTracker::API.new
	end 

	# !!important
	#cannot define "before do; ...; end;" because module cannot comprehend RSPEC hooks. need to add "RSpec.shared_context 'API helpers' do" above instead "module APIHelpers"
	before do 
		basic_authorize 'test_user', 'test_password'
	end
end


module ExpenseTracker #enclosed in module
	RSpec.describe 'Expense Tracker API', :db do 

		# include APIHelpers #inclusion of above module, can be grouped for each example
		include_context 'API helpers' #need to change to this to include above module !!important

		it 'records submitted expenses' do
			coffee = post_expense (
						'payee' => 'Starbucks', 
					   	'amount' => 5.75, 
					   	'date' => '2017-06-10'
					)

			zoo = post_expense ( 
					'payee' => 'Zoo', 
					'amount' => 15.25, 
					'date' => '2017-06-10'
				)

			groceries = post_expense( 
					'payee' => 'Whole Foods', 
					'amount' => 95.20, 
					'date' => '2017-06-11'
			)

			def post_expense(expense)		
				post '/expenses', JSON.generate(expense)
				expect(last_response.status).to eq(200) #last_response from Rack::Test

				parsed = JSON.parse(last_response.body) 
				expect(parsed).to include('expense_id' => a_kind_of(Integer))
				expense.merge('id' => parsed['expense_id']) #id generated from 'post' merged into the JSON


				get '/expenses/2017-06-10'				 			#query by date
				expect(last_response.status).to eq(200)				#query by date

				expenses = JSON.parse(last_response.body) 			#query by date
				expect(expenses).to contain_exactly(coffee, zoo)	#query by date
			end
		end 
	end 
end

#../app/api.rb

require 'sinatra/base'
require 'json'
require_relative 'ledger'

module ExpenseTracker 
	class API < Sinatra::Base 

		def initialize (ledger: Ledger.new) #when called api.new, new ledger automatically created
			@ledger = Ledger.new 
			super() # rest of initialization from Sinatra
		end

		post '/expenses' do 
			status 404

			expense = JSON.parse(request.body.read) 
			result = @ledger.record(expense) 
			JSON.generate('expense_id' => result.expense_id)
			#JSON.generate('expense_id' => 42) #sliming the test, means hardcoding result

			if result.success? 
				JSON.generate('expense_id' => result.expense_id)
			else 
				status 422
				JSON.generate('error' => result.error_message)
			end
		end

		get '/expenses/:date' do #query by date
			JSON.generate([])
		end

	end
end


# unit testing, differs in degree of isolation. class and method is tested seperately
#../app/api_spec.rb << test for the API model

require_relative '../../../app/api'
require 'rack/test'

module ExpenseTracker
	RSpec.describe API do 

		def app 
			API.new(ledger: ledger) 
		end 

		let(:ledger) { instance_double('ExpenseTracker::Ledger') }


		describe 'POST /expenses' do 
			context 'when the expense is successfully recorded' do 

				expense = { 'some' => 'data' }

				before do
					allow(ledger).to receive(:record) # when call ledger.record
					.with(expense)
					.and_return(RecordResult.new(true, 417, nil)) 
				end 

				it 'returns the expense id' 
					post '/expenses', JSON.generate(expense)

					parsed = JSON.parse(last_response.body) 
					expect(parsed).to include('expense_id' => 417)
				end

				it 'responds with a 200 (OK)'
					post '/expenses', JSON.generate(expense) 
					expect(last_response.status).to eq(200)
				end
			end

			context 'when the expense fails validation' do 
				let(:expense) { { 'some' => 'data' } }

				before do 
					allow(ledger).to receive(:record) 
					.with(expense) 
					.and_return(RecordResult.new(false, 417, 'Expense incomplete'))
				end

				it 'returns an error message' do 
					post '/expenses', JSON.generate(expense)
					parsed = JSON.parse(last_response.body) 	
					expect(parsed).to include('error' => 'Expense incomplete')
				end

				it 'responds with a 422 (Unprocessable entity)' do 
					post '/expenses', JSON.generate(expense) 
					expect(last_response.status).to eq(422)
				end
			end
		end
	end
end


#.../ledger.rb

module ExpenseTracker 
	RecordResult = Struct.new(:success?, :expense_id, :error_message)
	
	class Ledger 
		def record(expense)
		end
	end
end


#.../ledger_spec.rb

require_relative '../../../app/ledger' 
require_relative '../../../config/sequel' 
require_relative '../../support/db'

module ExpenseTracker 
	RSpec.describe Ledger do 
		let(:ledger) { Ledger.new } 
		let(:expense) do 
			{
				'payee' => 'Starbucks', 
				'amount' => 5.75, 
				'date' => '2017-06-10'
			} 
		end

		describe '#record' do
		end 
	end 
end