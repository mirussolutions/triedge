require 'rails_helper'

describe Answer do
  it { should validate_presence_of(:title) }
  it { should belong_to(:question) }
  it "saves anwers" do
  	answer = Answer.new(title: "title1")
  	answer.save
  	expect(Answer.first).to eq(answer)
  end

  it "belongs to question" do
  	ques = FactoryGirl.create(:question)
  	ans = FactoryGirl.create(:answer, question_id: ques.id)
  	expect(ques.answers.first).to eq(ans)
  end
end
