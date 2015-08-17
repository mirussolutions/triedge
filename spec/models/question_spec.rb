require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of(:title) }
  it { should belong_to(:quiz) }
  it " saves questions" do
  	ques = FactoryGirl.create(:question)
  	ques.save
  	expect(Question.first).to eq(ques)
  end

  it "belongs to quiz" do
  	quiz = Quiz.create(title: "quiz1")
  	ques = FactoryGirl.create(:question, quiz_id: quiz.id)
  	expect(quiz.questions.first).to eq(ques)
  end
end
