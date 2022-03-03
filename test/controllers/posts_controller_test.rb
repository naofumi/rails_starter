require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count") do
      post posts_url, params: { post: { content: @post.content,
                                        title: @post.title,
                                        tag_names: 'TagTwo, TagThree' } }
    end

    assert_redirected_to posts_path
    assert_equal 2, Post.last.tags.count
    assert_equal ["TagTwo", "TagThree"], Post.last.tags.map(&:name)
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: { post: { content: @post.content,
                                             title: @post.title,
                                             tag_names: 'TagTwo, TagThree' } }
    assert_redirected_to post_url(@post)
    assert_equal 2, Post.last.tags.count
    assert_equal ["TagTwo", "TagThree"], Post.last.tags.map(&:name)
  end
end
