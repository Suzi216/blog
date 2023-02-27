require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    Post.create do |post|
      post.title = 'Post 1'
      post.text = 'Helllo there'
      post.author = User.create do |user|
        user.name = 'User1'
        user.photo = 'https://'
        user.bio = 'developer'
        user.posts_counter = 1
      end
    end
  end
  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be integer' do
    subject.comments_counter = 'string'
    expect(subject).to_not be_valid
  end

  it 'title should be less than or equal to 250 characters' do
    subject.title = 'a' * 252
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be greater than or equal to 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be greater than or equal to 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'test update_posts_counter method' do
    expect(subject.author.posts_counter).to eq(3)
  end

end
