require 'rails_helper'

RSpec.describe Video, type: :model do
  it { should belong_to(:chapter)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
  it { should validate_presence_of(:video_url)}

  it " belongs to chapter" do
  	chapter = FactoryGirl.create(:chapter)
  	video = FactoryGirl.create(:video, chapter_id: chapter.id)
  	expect(chapter.videos.first).to eq(video)
  end
end
