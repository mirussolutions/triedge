class Admin::VideosController < ApplicationController
  load_and_authorize_resource
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  layout 'admin'
  
  # GET /admin/videos/1
  # GET /admin/videos/1.json
  def show
    @video = Video.find(params[:id])
    @chapter = Chapter.find(@video.chapter_id)
  end

  # GET /admin/videos/new
  def new
    @video = Video.new
    @chapter = Chapter.find(params[:chapter_id])
    @video.chapter_id = @chapter.id
  end

  # GET /admin/videos/1/edit
  def edit
    @chapter = Chapter.find(params[:chapter_id])
    @video.chapter_id = @chapter.id
  end

  # POST /admin/videos
  # POST /admin/videos.json
  def create
    @video = Video.new(video_params)
    @video.chapter_id = params[:chapter_id]
    @chapter = Chapter.find(@video.chapter_id)
    if @video.save
      flash[:success] = "You created a new video, '#{ @video.title }' for chapter #{ @video.chapter_id }."
      redirect_to admin_chapter_path(@video.chapter_id)
    else
      flash[:alert] = "The video could not be created. Please check the error messages."
      render :new
    end
    
  end

  # PATCH/PUT /admin/videos/1
  # PATCH/PUT /admin/videos/1.json
  def update
    @video = Video.find(params[:id])
    @chapter = Chapter.find(@video.chapter_id)
      if @video.update(video_params)
        flash[:success] = "You have updated video '#{@video.title}' successfully."
        redirect_to admin_chapter_video_path(params[:chapter_id], params[:id])
      else
        flash[:alert] = "The video was not updated. Please check the error messages."
        render :edit
      end
  end

  # DELETE /admin/videos/1
  # DELETE /admin/videos/1.json
  def destroy
    video = Video.find(params[:id])
    if @video.destroy
      flash[:success] = "You have deleted video #{ video.title} successfully."
      redirect_to admin_chapter_path(params[:chapter_id])
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:title, :description, :video_url, :chapter_id)
    end
end
