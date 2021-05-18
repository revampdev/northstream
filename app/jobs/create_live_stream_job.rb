class CreateLiveStreamJob < ApplicationJob
  queue_as :default

  def perform(stream, *_args)
    live_api = MuxRuby::LiveStreamsApi.new

    create_asset_request = MuxRuby::CreateAssetRequest.new
    create_asset_request.playback_policy = [MuxRuby::PlaybackPolicy::PUBLIC]
    create_live_stream_request = MuxRuby::CreateLiveStreamRequest.new
    create_live_stream_request.new_asset_settings = create_asset_request
    create_live_stream_request.playback_policy = [MuxRuby::PlaybackPolicy::PUBLIC]
    create_live_stream_request.reduced_latency = true
    mux_stream = live_api.create_live_stream(create_live_stream_request)
    logger.info mux_stream
    logger.info "create-live-stream OK ✅"
    # Do something later
    stream.stream_key = mux_stream.data.stream_key
    stream.live_stream_id = mux_stream.data.id
    stream.status = mux_stream.data.status
    stream.playback_id = mux_stream.data.playback_ids[0].id
    puts "stream updated" if stream.save!
  end
end
