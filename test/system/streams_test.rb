require "application_system_test_case"

class StreamsTest < ApplicationSystemTestCase
  setup do
    @stream = streams(:one)
  end

  test "visiting the index" do
    visit streams_url
    assert_selector "h1", text: "Streams"
  end

  test "creating a Stream" do
    visit streams_url
    click_on "New Stream"

    fill_in "Account", with: @stream.account_id
    fill_in "Live stream", with: @stream.live_stream_id
    fill_in "Name", with: @stream.name
    fill_in "Playback", with: @stream.playback_id
    fill_in "Price", with: @stream.price
    fill_in "Slug", with: @stream.slug
    fill_in "Status", with: @stream.status
    fill_in "Stream date", with: @stream.stream_date
    fill_in "Stream key", with: @stream.stream_key
    fill_in "Stream rtmp link", with: @stream.stream_rtmp_link
    click_on "Create Stream"

    assert_text "Stream was successfully created"
    assert_selector "h1", text: "Streams"
  end

  test "updating a Stream" do
    visit stream_url(@stream)
    click_on "Edit", match: :first

    fill_in "Account", with: @stream.account_id
    fill_in "Live stream", with: @stream.live_stream_id
    fill_in "Name", with: @stream.name
    fill_in "Playback", with: @stream.playback_id
    fill_in "Price", with: @stream.price
    fill_in "Slug", with: @stream.slug
    fill_in "Status", with: @stream.status
    fill_in "Stream date", with: @stream.stream_date
    fill_in "Stream key", with: @stream.stream_key
    fill_in "Stream rtmp link", with: @stream.stream_rtmp_link
    click_on "Update Stream"

    assert_text "Stream was successfully updated"
    assert_selector "h1", text: "Streams"
  end

  test "destroying a Stream" do
    visit edit_stream_url(@stream)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Stream was successfully destroyed"
  end
end
