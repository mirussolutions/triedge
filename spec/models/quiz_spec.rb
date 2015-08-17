require 'rails_helper'

describe Quiz do
  it { should validate_presence_of(:title) }
  it "saves quizzes" do
  	quiz = Quiz.new(title: "quiz1")
  	quiz.save
  	expect(Quiz.first).to eq(quiz)
  end

  it "belongs to chapter" do
  	chapter = FactoryGirl.create(:chapter)
  	quiz = Quiz.create(title: "quiz1", chapter_id: chapter.id)
  	expect(chapter.quiz).to eq(quiz)
  end
end
