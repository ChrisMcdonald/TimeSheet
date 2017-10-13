FactoryGirl.define do
  factory :user do
	  sequence(:id) {|number| number}

	  password 'Passw0rd'
	  password_confirmation "Passw0rd"
	  sequence(:first_name) {|n| "#{n}#{Faker::Name.first_name }"}
	  sequence(:last_name) {|n| "#{n}#{Faker::Name.last_name }"}
	  sequence(:email) {|n| "#{n}#{Faker::Internet.email}"}

  end
end