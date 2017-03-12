require 'spec_helper'
# require 'rails_helper'

describe CarsController do
  let(:gas_grade) { FactoryGirl.create(:gas_grade) }
  let(:car) { FactoryGirl.create(:car, gas_grade_id: gas_grade.id) }
  let(:user_without_car) { FactoryGirl.create(:user) }
  let(:user_with_car) {  FactoryGirl.create(:user, car_id: car.id)}
  describe '#index' do
    context 'current user does not have a car' do
      before :each do
        sign_in user_without_car
        get :index
      end
    it 'will redirect to new car page' do
      expect(response).to be_redirect
    end
    end
    context 'current user has a car' do
      before :each do
        sign_in user_with_car
        get :index
      end
      it 'returns success' do
        # expect(response.status).to eq(200)
        expect(user_with_car.car).to eq(car)
      end
    end

  end


end
