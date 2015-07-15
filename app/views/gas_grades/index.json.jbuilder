json.array!(@gas_grades) do |gas_grade|
  json.extract! gas_grade, :id
  json.url gas_grade_url(gas_grade, format: :json)
end
