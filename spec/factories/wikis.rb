FactoryGirl.define do
  factory :wiki do
    user
    title "Wiki Title"
    body "Wiki Body"
    private false
  end
end
