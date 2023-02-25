require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject do
    Comment.create do |comment|
      comment.post = Post.create do |post|
        post.title = 'Post'
        post.text = 'Hello there'
        post.author = User.create do |user|
          user.name = 'Suzana'
          user.photo = 'https://'
          user.bio = 'Deveoper'
        end
      end
      comment.author = User.create do |user|
        user.name = 'Ana'
        user.photo = 'https://'
        user.bio = 'Deeveloper'
      end
      comment.text= 'First Comment'
    end
  end

  it 'test update_comments_counter method' do
    expect(subject.post.comments_counter).to eq(1)

    Comment.create do |comment|
      comment.post = subject.post
      comment.author = subject.author
      comment.text = 'second comment'
    end
    
    expect(subject.post.comments_counter).to eq(2)
  end
end
