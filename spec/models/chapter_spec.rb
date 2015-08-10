require 'rails_helper'

describe Chapter do
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
  it "saves it own" do
  	 chapter = FactoryGirl.create(:chapter)
  	 chapter.save
     expect(Chapter.first).to eq(chapter)
  end

end
