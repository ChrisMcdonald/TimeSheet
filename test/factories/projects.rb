FactoryGirl.define do
  factory :project do
	  sequence(:id) {|number| number}
	  name "MyString"
  end
end
