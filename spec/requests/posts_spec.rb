require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET/index' do
    before(:example) { get '/users/:user_id/posts' }
    it 'http request returns success and check correct placeholder text.' do
      # get '/users/:author_id/posts'
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Tom')
    end
  end

  # describe 'GET/show' do
  #   it 'http request returns success and check correct placeholder text.' do
  #     get '/users/:author_id/posts/:id'
  #     expect(response).to have_http_status(:ok)
  #     expect(response.body).to include('by Tom')
  #   end
  # end
end
