require 'rails_helper'

RSpec.describe User, type: :system do
  subject { User.new(name: 'Suzana', posts_counter: 3, photo: 'https://www.shutterstock.com/image-photo/white-lily-flower-isolated-on-260nw-1705942645.jpg', bio: 'Developer') }

  before { subject.save }

  describe 'index page' do
    it 'I can see the username of all other users' do
      visit users_path
      expect(page).to have_content(subject.name)
    end

    it 'I can see the profile picture for each user' do
      visit users_path
      page.has_content?(subject.posts_counter)
    end

    it 'I can see the number of posts each user has written.' do
      visit users_path
      page.has_content?(subject.posts_counter)
    end

    it "When I click on a user, I am redirected to that user's show page." do
      user2 = User.create(name: 'Besa', posts_counter: 2,
                          photo: 'https://www.shutterstock.com/image-photo/white-lily-flower-isolated-on-260nw-1705942645.jpg', bio: 'Developer')
      visit user_path(user2.id)
      page.has_content?('Besa')
    end
  end

  
end
