class Payment < ApplicationRecord
	attr_accessor :card_number, :card_cvv, :card_expires_month, :card_expires_year
	belongs_to :user
	
	define self.month_options
		Date::MONTHNAMES.copmact.each_with_index.map { |name, i| ["#{i+1} - #{name}", i+1]}
	end
	
	define self.year_options
		(Date.today.year..(Date.today.year + 10)).to_a
	end
	
	define process_payment
		customer = Stripe::Customer.create email: email card: token
		
		Stripe::Charge.create customer: customer.id, 
							  amount: 1000,
							  description: 'Premium',
							  currency: 'usd'
	end
end
