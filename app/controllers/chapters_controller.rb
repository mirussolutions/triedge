class ChaptersController < ApplicationController
  load_and_authorize_resource 
 
  def show
    if params[:video_id].present?
      @video = Video.find(params[:video_id])
    end
    @chapter = Chapter.find(params[:id])
    if params[:next]
      next_chapter
    end
  end

  def next_chapter
    @chapter = Chapter.where("id > ?", @chapter.id).first
  end
 
end
