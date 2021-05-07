require "test_helper"

class StreamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stream = streams(:one)
  end

  test "should get index" do
    get streams_url
    assert_response :success
  end

  test "should get new" do
    get new_stream_url
    assert_response :success
  end

  test "should create stream" do
    assert_difference('Stream.count') do
      post streams_url, params: { stream: { account_id: @stream.account_id, live_stream_id: @stream.live_stream_id, name: @stream.name, playback_id: @stream.playback_id, price: @stream.price, slug: @stream.slug, status: @stream.status, stream_date: @stream.stream_date, stream_key: @stream.stream_key, stream_rtmp_link: @stream.stream_rtmp_link } }
    end

    assert_redirected_to stream_url(Stream.last)
  end

  test "should show stream" do
    get stream_url(@stream)
    assert_response :success
  end

  test "should get edit" do
    get edit_stream_url(@stream)
    assert_response :success
  end

  test "should update stream" do
    patch stream_url(@stream), params: { stream: { account_id: @stream.account_id, live_stream_id: @stream.live_stream_id, name: @stream.name, playback_id: @stream.playback_id, price: @stream.price, slug: @stream.slug, status: @stream.status, stream_date: @stream.stream_date, stream_key: @stream.stream_key, stream_rtmp_link: @stream.stream_rtmp_link } }
    assert_redirected_to stream_url(@stream)
  end

  test "should destroy stream" do
    assert_difference('Stream.count', -1) do
      delete stream_url(@stream)
    end

    assert_redirected_to streams_url
  end
end
