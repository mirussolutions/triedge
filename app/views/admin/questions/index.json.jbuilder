json.array!(@questions) do |question|
  json.extract! question, :title, :quiz_id
  json.url question_url(question, format: :json)
end