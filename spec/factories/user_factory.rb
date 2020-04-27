# This will guess the User class
FactoryBot.define do
  factory :user do
    nick { "SomeNick" }
    dob { Date.current - 21.years }
    account_status { :active }
  end
end
