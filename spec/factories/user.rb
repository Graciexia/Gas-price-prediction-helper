
# create_table "users", force: :cascade do |t|
#   t.string   "email",                  default: "",    null: false
#   t.string   "encrypted_password",     default: "",    null: false
#   t.string   "reset_password_token"
#   t.datetime "reset_password_sent_at"
#   t.datetime "remember_created_at"
#   t.integer  "sign_in_count",          default: 0,     null: false
#   t.datetime "current_sign_in_at"
#   t.datetime "last_sign_in_at"
#   t.inet     "current_sign_in_ip"
#   t.inet     "last_sign_in_ip"
#   t.string   "name"
#   t.boolean  "admin",                  default: false
#   t.string   "address"
#   t.integer  "zipcode"
#   t.integer  "city_id"
#   t.integer  "car_id"
#   t.datetime "created_at",                             null: false
#   t.datetime "updated_at",                             null: false
# end

FactoryGirl.define do
  factory :user do
    email "isatest@abc.com"
    password "12345678"
    password_confirmation "12345678"
    admin false
    name "wei"
    city_id 1

    trait :with_car do
      car_id 1
    end
  end
end