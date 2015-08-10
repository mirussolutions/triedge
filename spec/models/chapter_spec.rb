require 'rails_helper'

describe Chapter do
  it { should belong_to(:course)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
  it "saves it own" do
  	 chapter = FactoryGirl.create(:chapter)
  	 chapter.save
     expect(Chapter.first).to eq(chapter)
  end

 it " belongs to a course" do
 	course = FactoryGirl.create(:course)
 	chapter = FactoryGirl.create(:chapter, course_id: course.id)
 	expect(course.chapters.first).to eq(chapter)
 end
end
