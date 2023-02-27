require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET/index' do
    it 'http request returns success and check correct placeholder text.' do
      get '/'
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('List of All Users')
    end
  end

  describe 'GET/show' do
    it 'http request returns success and check correct placeholder text.' do
      get '/users/:id'
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('User details')
    end
  end
 end