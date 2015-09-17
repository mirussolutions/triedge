require 'rails_helper'

describe Evaluation do
  context "evaluation succeeds" do
    let(:quiz) { quiz = FactoryGirl.create(:quiz) }
    let(:user) { user = FactoryGirl.create(:user) }
    let(:question) { FactoryGirl.create(:question, quiz_id: quiz.id) }
    let(:answer) { FactoryGirl.create(:answer, is_correct: true, question_id: question.id) }

    it "passes the quiz" do
      user.answers << answer
      evaluation = Evaluation.new(quiz, user)
      expect(evaluation.pass?).to be true
    end

    it "adds the quiz to the users quizzes when quiz complete" do
      user.answers << answer
      evaluation = Evaluation.new(quiz, user)
      evaluation.pass?
      expect(user.quizzes.first).to eq(quiz) 
    end
  end

  context "evaluation fails" do
    let(:quiz) { quiz = FactoryGirl.create(:quiz) }
    let(:user) { user = FactoryGirl.create(:user) }
    let(:question1) { FactoryGirl.create(:question, quiz_id: quiz.id) }
    let(:question2) { FactoryGirl.create(:question, quiz_id: quiz.id) }
    let(:question3) { FactoryGirl.create(:question, quiz_id: quiz.id) }
    let(:answer1) { FactoryGirl.create(:answer, is_correct: false, question_id: question1.id) }
    let(:answer2) { FactoryGirl.create(:answer, is_correct: false, question_id: question2.id) }
    let(:answer3) { FactoryGirl.create(:answer, is_correct: false, question_id: question3.id) }



    it "doesn't pass the quiz" do
      user.answers << [ answer1, answer2, answer3 ]
      evaluation = Evaluation.new(quiz, user)
      expect(evaluation.pass?).to be nil
    end

    it "does not add the quiz to the user's quizzes when quiz is not passed" do
      user.answers << [ answer1, answer2, answer3 ]
      evaluation = Evaluation.new(quiz, user)
      evaluation.pass?
      expect(user.quizzes).to eq([]) 
    end
  end
end
