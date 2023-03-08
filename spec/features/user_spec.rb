require 'rails_helper'

RSpec.describe User, type: :system do
  subject { User.new(name: 'Suzana', posts_counter: 3, photo: 'https://www.shutterstock.com/image-photo/white-lily-flower-isolated-on-260nw-1705942645.jpg', bio: 'Developer') }

  before { subject.save }

  describe 'index page' do
    it 'I can see the username of all other users' do
      visit users_path
      page.has_content?(subject.name)
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
      user2 = User.create(name: 'Besa', posts_counter: 2, photo: 'https://www.shutterstock.com/image-photo/white-lily-flower-isolated-on-260nw-1705942645.jpg', bio: 'Developer')
      visit user_path(user2.id)
      page.has_content?('Besa')
    end
   end

  describe 'User show page' do
    it "I can see the user's profile picture." do
      visit user_path(subject.id)
      page.has_css?('.img-fluid')
    end

    it "I can see the user's username." do
      visit user_path(subject.id)
      page.has_content?(subject.name)
    end

    it 'I can see the number of posts the user has written.' do
      visit user_path(subject.id)
      page.has_content?(subject.posts_counter)
    end

    it "I can see the user's bio." do
      visit user_path(subject.id)
      page.has_content?(subject.bio)
    end

    it "I can see the user's first 3 posts." do
      Post.create([{ author: subject, title: 'First Post', text: 'My first post' },
                   { author: subject, title: 'Second Post', text: 'My Second post' }, { author: subject, title: 'Third Post', text: 'My Third post' }])
      visit user_path(subject.id)
      page.has_content?(subject.posts)
    end

    it "I can see a button that lets me view all of a user's posts." do
      visit user_path(subject.id)
      page.has_button?('See all posts')
    end

    it "When I click a user's post, it redirects me to that post's show page." do
      post = Post.create(author: subject, title: 'Post', text: 'More post')
      visit user_path(subject.id)
      visit user_post_path(subject.id, post.id)
      page.has_content?(post.title)
    end

    it "When I click to see all posts, it redirects me to the user's post's index page." do
      visit user_path(subject.id)
      visit user_posts_path(subject.id)
      page.has_content?('Suzana')
    end
   end
end