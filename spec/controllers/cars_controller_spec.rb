require 'spec_helper'
# require 'rails_helper'

describe CarsController do
  let(:gas_grade){ FactoryGirl.create(:gas_grade) }
  let(:car){ FactoryGirl.create(:car, gas_grade_id: gas_grade.id) }
  let(:city){ FactoryGirl.create(:city) }
  let(:user_without_car){ FactoryGirl.create(:user, email: "isatest@abc.com") }
  let(:user_with_car){ FactoryGirl.create(:user, email: "isatest2@abc.com", car_id: car.id, city_id: city.id) }

  describe '#index' do
    let(:user_gas_price){FactoryGirl.build(:gas_price, city_id: user_with_car.city_id, gas_grade_id: gas_grade.id)}
    let(:sipper_gas_price){1.09}
    let(:guzzler_gas_price){3.09}
    before :each do
      allow(@user_gas_price).to receive(:gas_price).and_return(user_gas_price)
      allow(@sipper_gas_price).to receive(:gas_grade_id).and_return(sipper_gas_price)
      allow(@guzzler_gas_price).to receive(:gas_grade_id).and_return(guzzler_gas_price)
    end
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
        expect(response.status).to eq(200)
      end
    end
  end

  describe '#show' do
    before :each do
      sign_in user_with_car
      get :show, id: user_with_car.car_id
    end
    it 'returns success' do
      expect(response.status).to eq(200)
    end
  end

  describe '#new' do
    context 'current user has a car' do
      before :each do
        sign_in user_with_car
        get :new
      end
      it 'will redirect to edit car page' do
        expect(response).to redirect_to(edit_car_path car.id)
      end
    end
    context 'current user does not have a car' do
      before :each do
        sign_in user_without_car
        get :new
      end
      it 'returns success' do
        expect(response.status).to eq(200)
      end
    end
  end
end
