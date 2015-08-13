json.array!(@videos) do |video|
  json.extract! video, :title, :description, :video_url, :chapter_id
  json.url video_url(video, format: :json)
end