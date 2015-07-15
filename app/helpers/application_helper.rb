module ApplicationHelper
  def resource_name
    :user
  end

  def resource_class
     User
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def city_dropdown
    City.all.map{|city| [city.state + '-' + city.name,city.id]}.sort
  end

  def gas_grade_dropdown
    GasGrade.all.map{|gas_grade| [gas_grade.grade_name,gas_grade.id]}
  end

end


