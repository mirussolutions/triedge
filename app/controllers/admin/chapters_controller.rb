class Admin::ChaptersController < AdminController
  before_action :set_chapter, only: [:show, :edit, :update, :destroy]

  # GET /admin/chapters
  # GET /admin/chapters.json
  def index
    @chapters = Chapter.all
  end

  # GET /admin/chapters/1
  # GET /admin/chapters/1.json
  def show
  end

  # GET /admin/chapters/new
  def new
    @chapter = Chapter.new
  end

  # GET /admin/chapters/1/edit
  def edit
  end

  # POST /admin/chapters
  # POST /admin/chapters.json
  def create
    @chapter = Chapter.new(chapter_params)

    respond_to do |format|
      if @chapter.save
        format.html { redirect_to [:admin, @chapter], notice: 'Chapter was successfully created.' }
        format.json { render action: 'show', status: :created, location: @chapter }
      else
        format.html { render action: 'new' }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/chapters/1
  # PATCH/PUT /admin/chapters/1.json
  def update
    respond_to do |format|
      if @chapter.update(chapter_params)
        format.html { redirect_to [:admin, @chapter], notice: 'Chapter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/chapters/1
  # DELETE /admin/chapters/1.json
  def destroy
    @chapter.destroy
    respond_to do |format|
      format.html { redirect_to admin_chapters_url, notice: 'Chapter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter
      @chapter = Chapter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chapter_params
      params.require(:chapter).permit(:title, :description, :course_id)
    end
end
