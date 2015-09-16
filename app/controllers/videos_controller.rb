class VideosController < ApplicationController
  load_and_authorize_resource
  
  def show
    @video = Video.find(params[:id])
    add_video
    chapter = Chapter.find(params[:chapter_id])
    course = Course.find(chapter.course_id)
    redirect_to course_chapter_path(course_id: course.id, id: chapter.id, video_id: @video.id)
  end
  def add_video
    current_user.videos << @video unless current_user.videos.include?(@video)
  end
end
