json.array!(@answers) do |answer|
  json.extract! answer, :title, :is_correct, :question_id
  json.url answer_url(answer, format: :json)
end