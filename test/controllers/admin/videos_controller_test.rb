require 'test_helper'

class Admin::VideosControllerTest < ActionController::TestCase
  setup do
    @video = videos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:videos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create video" do
    assert_difference('Video.count') do
      post :create, video: { chapter_id: @video.chapter_id, description: @video.description, title: @video.title, video_url: @video.video_url }
    end

    assert_redirected_to admin_video_path(assigns(:video))
  end

  test "should show video" do
    get :show, id: @video
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @video
    assert_response :success
  end

  test "should update video" do
    patch :update, id: @video, video: { chapter_id: @video.chapter_id, description: @video.description, title: @video.title, video_url: @video.video_url }
    assert_redirected_to admin_video_path(assigns(:video))
  end

  test "should destroy video" do
    assert_difference('Video.count', -1) do
      delete :destroy, id: @video
    end

    assert_redirected_to admin_videos_path
  end
end
