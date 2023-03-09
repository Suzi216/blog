require 'rails_helper'

RSpec.describe Post, type: :system do
  user = User.create(name: 'Andrea', posts_counter: 2,
                     photo: 'https://www.shutterstock.com/image-photo/white-lily-flower-isolated-on-260nw-1705942645.jpg', bio: 'Developer')

  subject do
    Post.new(author_id: user.id, title: 'Mister', text: 'First post', comments_counter: 1, likes_counter: 1)
  end
  before { subject.save }

  describe 'Post index page' do
    it 'I can see the user picture.' do
      visit user_posts_path(user.id)
      page.has_css?('.img-fluid')
    end

    it 'Show user username.' do
      visit user_posts_path(user.id)
      expect(page).to have_content(user.name)
    end

    it 'Show the number of post.' do
      visit user_posts_path(user.id)
      page.has_content?(user.posts_counter)
    end

    it 'Show post title.' do
      visit user_posts_path(user.id)
      page.has_content?(subject.title)
    end

    it 'Show post body.' do
      visit user_posts_path(user.id)
      page.has_content?(subject.text)
    end
    it 'I can see the first comments on a post.' do
      comment = Comment.new(author_id: user.id, post_id: subject.id, text: 'No comment')
      visit user_posts_path(user.id)
      page.has_content?(comment.text)
    end

    it 'I can see how many comments a post has' do
      visit user_posts_path(user.id)
      page.has_content?(subject.comments_counter)
    end

    it 'When I click on a post, it redirects me to that posts show page.' do
      visit user_posts_path(user.id)
      visit user_post_path(user.id, subject.id)
      page.has_content?(subject.title)
    end
  end

  describe 'Post show page' do
    it "I can see the post's title." do
      visit user_post_path(user.id, subject.id)
      page.has_content?(subject.title)
    end
    it 'I can see who wrote the post.' do
      visit user_post_path(user.id, subject.id)
      page.has_content?(user.name)
    end
    it 'I can see how many comments it has.' do
      visit user_post_path(user.id, subject.id)
      page.has_content?(subject.comments_counter)
    end
    it 'I can see how many likes it has.' do
      visit user_post_path(user.id, subject.id)
      page.has_content?(subject.likes_counter)
    end
    it 'I can see the post body.' do
      visit user_post_path(user.id, subject.id)
      page.has_content?(subject.text)
    end
    it 'I can see the username of each commentor.' do
      comment = Comment.new(author_id: user.id, post_id: subject.id, text: 'I like it')
      visit user_post_path(user.id, subject.id)
      page.has_content?(comment.author.name)
    end
    it 'I can see the comment each commentor left. ' do
      comment = Comment.new(author_id: user.id, post_id: subject.id, text: 'I like it')
      visit user_post_path(user.id, subject.id)
      page.has_content?(comment.text)
    end
  end
end
