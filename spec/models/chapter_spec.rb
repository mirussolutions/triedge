require 'rails_helper'

describe Chapter do
  it { should belong_to(:course)}
  it { should have_many(:videos)}
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

 it " has many videos " do
 	chapter = FactoryGirl.create(:chapter)
 	video1 = FactoryGirl.create(:video, chapter_id: chapter.id)
 	video2 = FactoryGirl.create(:video, chapter_id: chapter.id)
 	expect(chapter.videos).to include(video1, video2)
 end
end
