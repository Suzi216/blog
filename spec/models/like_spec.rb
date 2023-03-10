require 'rails_helper'

describe Like, type: :model do
  before :each do
    @author = User.new(name: 'Henew', photo: 'https://', bio: 'Developer')
    @post = Post.new(author: @author, title: 'First', text: 'Post')

    @like = Like.create(author: @author, post: @post)
  end

  it 'test update_likes_counter method ' do
    expect(@post.likes_counter).to eq 1
  end
end
