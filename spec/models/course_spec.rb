require 'rails_helper'

describe Course do
  it { should have_many(:chapters)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
  it "saves itself" do
  	course = Course.new(:title => "course1", :description => "this is test for course1")
  	course.save
  	expect(Course.first).to eq(course)
  end

  it "has many chapters" do
  	course = FactoryGirl.create(:course)
  	chapter1 = FactoryGirl.create(:chapter, course_id: course.id)
  	chapter2 = FactoryGirl.create(:chapter, course_id: course.id)
  	expect(course.chapters).to include(chapter1, chapter2)
  end
end
