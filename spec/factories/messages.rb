FactoryBot.define do
  factory :message do
    text "MyString"
    send_at "2018-04-11 22:16:19"
    from nil
    to nil
  end
end
