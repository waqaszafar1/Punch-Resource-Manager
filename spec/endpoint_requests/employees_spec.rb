require 'rails_helper'

RSpec.describe 'Employee API', type: :request do
  # initialize test data
  let!(:user) { create_list(:user, 1) }
  let!(:employees) { create_list(:employee, 10) }
  let(:employee_id) {employees.first.id}
  before(:each) do
    post "/api/v1/login", params: { :email =>"example@example.com", :password => "waqas1234"}
    @auth_token = eval(response.body)[:token]
  end

  #Test suite for GET /employees
  describe 'GET /employees' do
    # make HTTP get request before each example
    before {
      headers = {
        token: @auth_token
    }
    get "/api/v1/employees" #I just didn't send authentication
                            # token to show it will work too
    }

    it 'returns employees' do
      expect(response.body).not_to be_empty
      expect(eval(response.body).size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  #Test suite for GET /employees/:id
  describe 'GET /api/v1/employees/:id' do
    before {  headers = {
        token: @auth_token
    }
        get "/api/v1/employees/#{employee_id}" , :headers => headers

    }
    context 'when the record exists' do
      it 'returns the employee' do
        expect(response.body).not_to be_empty
        expect(eval(response.body)[:id]).to eq(employee_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:employee_id) { 100 }

      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/No such employee found./)
      end
    end
  end
  #
  # # Test suite for POST /employees
  describe 'POST /api/v1/employees' do

    # valid payload
    let(:valid_attributes) {{ employee: { name: 'Waqas Zafar', designation: 'RoR Developer' }}}
    context 'when the request is valid' do

      before {
        headers = {
          token: @auth_token
        }
        post '/api/v1/employees', params: valid_attributes, :headers => headers
      }

      it 'creates an employee' do

        expect(eval(response.body)[:message]).to match(/name: Waqas Zafar/)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before {
        headers = {
          token: @auth_token
      }
        post '/api/v1/employees', params: { employee: { name: 'Waqas007' }},:headers => headers }

      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Designation can't be blank/)
      end
    end
    end
  # Test suite for PUT /emplpoyees/:id
  describe 'PUT /emplpoyees/:id' do
    let(:valid_attributes) {{ employee: { name: 'Waqas updated' }} }

    context 'when the record exists' do
      before{
      headers = {
          token: @auth_token
      }
      put "/api/v1/employees/#{employee_id}" , params: valid_attributes,  :headers => headers
      }

      it 'updates the record' do
        expect(response.body).to match(/name: Waqas updated/)
      end
    end
  end

  # Test suite for PUT /emplpoyees/:id
  describe 'PUT /emplpoyees/:id' do
    let(:valid_attributes) {{ employee: { name: 'Waqas updated' }} }

    context 'when the record exists' do
      before{
        headers = {
            token: @auth_token
        }
        put "/api/v1/employees/#{employee_id}" , params: valid_attributes,  :headers => headers
      }

      it 'updates the record' do
        expect(response.body).to match(/name: Waqas updated/)
      end
      employee_id = 15


    end

  context 'when the record doesnt exists' do
    before{
      headers = {
          token: @auth_token
      }
      put "/api/v1/employees/155" , params: valid_attributes,  :headers => headers
    }


    it 'cant update the employee' do
      expect(response.body).to match(/No such employee found./)
    end
  end
end

  describe 'DELETE /emplpoyees/:id' do
    context 'when the record exists' do
      before{
        headers = {
            token: @auth_token
        }
        delete "/api/v1/employees/#{employee_id}" ,  :headers => headers
      }

      it 'delete the record' do
        expect(response.body).to match(/Employee has been deleted succesfully!/)
      end
    end
    context 'when the record doesnt exists' do
      before{
        headers = {
            token: @auth_token
        }
        delete "/api/v1/employees/542" ,  :headers => headers
      }

      it 'it doesnt delete record' do
        expect(response.body).to match(/No such employee found./)
      end
    end
  end
end

