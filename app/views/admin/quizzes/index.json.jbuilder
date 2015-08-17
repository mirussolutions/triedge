json.array!(@quizzes) do |quiz|
  json.extract! quiz, :title, :chapter_id
  json.url quiz_url(quiz, format: :json)
end