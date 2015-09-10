require 'rails_helper'

describe Admin::VideosController do
  describe "GET #show" do
    before do
      @chapter = FactoryGirl.create(:chapter)
      @video = FactoryGirl.create(:video, chapter_id: @chapter.id)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { get :show, chapter_id: @chapter.id, id: @video.id }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { get :show, chapter_id: @chapter.id, id: @video.id }
    end
    context "If user is loggedin as an admin" do
      login_admin
      it "renders the :show template" do
        get :show, chapter_id: @chapter.id, id: @video.id
        expect(response).to render_template :show
      end
      it "returns a video" do
        get :show, chapter_id: @chapter.id, id: @video.id
        expect(assigns(:video)).to be_present 
      end
      it "returns a video for the chapter" do
        get :show, chapter_id: @chapter.id, id: @video.id
        expect(assigns(:video).chapter_id).to eq(@video.chapter_id) 
      end
    end
    context "with invalid user logged in" do
            it "redirects to the sign in page" do
             get :show, chapter_id: @chapter.id, id: @video.id
             expect(response).to redirect_to new_user_session_path
            end
        end
  end
  describe "GET #new" do
    before do
      @course = FactoryGirl.create(:course)
      @chapter = FactoryGirl.create(:chapter, course_id: @course.id)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { get :new, chapter_id: @chapter.id}
    end
    it_behaves_like "admin mandatory" do
      let(:action) { get :new, chapter_id: @chapter.id }
    end
    context "If user is loggedin as an admin" do
      login_admin
      it "sets the video to a new video" do
        get :new, chapter_id: @chapter.id
        expect(assigns(:video)).to be_instance_of(Video)
        expect(assigns(:video)).to be_new_record
      end

      it "assigns a chapter to the video" do
        get :new, chapter_id: @chapter.id
        expect(assigns(:video).chapter_id).to eq(@chapter.id) 
      end
    end
    context "if user loggedin as a regular user" do
      login_user
      it "sets the flash error message" do
        expect{ get :new, chapter_id: @chapter.id }.to raise_error(CanCan::AccessDenied)
      end
     end
  end
  describe "POST #create" do
    before do
      @course = FactoryGirl.create(:course)
      @chapter = FactoryGirl.create(:chapter, course_id: @course.id)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { post :create, chapter_id: @chapter.id}
    end
    it_behaves_like "admin mandatory" do
      let(:action) { post :create, chapter_id: @chapter.id }
    end
    context "with valid attributes" do
      login_admin
      it "redirects to the chapter show page" do
        post :create, chapter_id: @chapter.id, video: { title: "team management", description: "how would you manage a team", video_url: "http://triedge.in/admin/assets/media_library/library_video/143495500620150501_171720_VP8.webm", chapter_id: @chapter.id }
        expect(response).to redirect_to admin_chapter_path(@chapter.id)
      end
      it "creates a new video" do
        post :create, chapter_id: @chapter.id, video: { title: "team management", description: "how would you manage a team", video_url: "http://triedge.in/admin/assets/media_library/library_video/143495500620150501_171720_VP8.webm", chapter_id: @chapter.id }
        expect(Video.count).to eq(1) 
      end
      it "flashes a success message" do
        post :create, chapter_id: @chapter.id, video: { title: "team management", description: "how would you manage a team", video_url: "http://triedge.in/admin/assets/media_library/library_video/143495500620150501_171720_VP8.webm", chapter_id: @chapter.id }
        expect(flash[:success]).to be_present 

      end
    end
    context "with invalidvalid attributes" do
      login_admin
      it "renders the :new template" do
        post :create, chapter_id: @chapter.id, video: { description: "how would you manage a team", video_url: "http://triedge.in/admin/assets/media_library/library_video/143495500620150501_171720_VP8.webm", chapter_id: @chapter.id }
        expect(response).to render_template :new 
      end
      it "doesn't create a new chapter" do
        post :create, chapter_id: @chapter.id, video: { description: "how would you manage a team", video_url: "http://triedge.in/admin/assets/media_library/library_video/143495500620150501_171720_VP8.webm", chapter_id: @chapter.id }
        expect(Video.count).to eq(0) 
      end
      it "sets the @video variable" do
        post :create, chapter_id: @chapter.id, video: { description: "how would you manage a team", video_url: "http://triedge.in/admin/assets/media_library/library_video/143495500620150501_171720_VP8.webm", chapter_id: @chapter.id }
        expect(assigns(:video)).to be_present 
      end
      it "sets the flash error message" do
        post :create, chapter_id: @chapter.id, video: { description: "how would you manage a team", video_url: "http://triedge.in/admin/assets/media_library/library_video/143495500620150501_171720_VP8.webm", chapter_id: @chapter.id }
        expect(flash[:alert]).to be_present 
      end
    end
  end
  describe "PUT #update" do
    before do
      @course = FactoryGirl.create(:course)
      @chapter = FactoryGirl.create(:chapter, course_id: @course.id)
      @video = FactoryGirl.create(:video, chapter_id: @chapter.id )
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { put :update, chapter_id: @chapter.id, id: @video.id }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { put :update, chapter_id: @chapter.id, id: @video.id }
    end
    context "with valid attributes" do
      login_admin
      it "redirects to the video show page" do
        put :update, chapter_id: @chapter.id, id: @video.id, video: { title: "title new", description: "how would you manage a team", video_url: "http://triedge.in/admin/assets/media_library/library_video/143495500620150501_171720_VP8.webm", chapter_id: @chapter.id }
        expect(response).to redirect_to admin_chapter_video_path(@video.chapter_id, @video.id) 
      end
      it "updates the video" do
         put :update, chapter_id: @chapter.id, id: @video.id, video: { title: "title new", description: "how would you manage a team", video_url: "http://triedge.in/admin/assets/media_library/library_video/143495500620150501_171720_VP8.webm", chapter_id: @chapter.id }
        @video.reload
        expect(assigns(:video).title).to eq("title new") 
      end
      it "flashes a success message" do
        put :update, chapter_id: @chapter.id, id: @video.id, video: { title: "title new", description: "how would you manage a team", video_url: "http://triedge.in/admin/assets/media_library/library_video/143495500620150501_171720_VP8.webm", chapter_id: @chapter.id }
        @video.reload
        expect(flash[:success]).to be_present 
      end
    end
    context "with invalid attributes " do
      login_admin
      it "renders the :edit template" do
        put :update, chapter_id: @chapter.id, id: @video.id, video: { title: "title new", description: "", video_url: "http://triedge.in/admin/assets/media_library/library_video/143495500620150501_171720_VP8.webm", chapter_id: @chapter.id }
        @video.reload
        expect(response).to render_template :edit 
      end
      it "doesn't update the video" do
        put :update, chapter_id: @chapter.id, id: @video.id, video: { title: "title new", description: "", video_url: "http://triedge.in/admin/assets/media_library/library_video/143495500620150501_171720_VP8.webm", chapter_id: @chapter.id }
        @video.reload
        expect(@video.description).not_to eq("")
      end
      it "flashes an error message" do
       put :update, chapter_id: @chapter.id, id: @video.id, video: { title: "title new", description: "", video_url: "http://triedge.in/admin/assets/media_library/library_video/143495500620150501_171720_VP8.webm", chapter_id: @chapter.id }
        @video.reload
        expect(flash[:alert]).to be_present 
      end
      it "sets the @video" do
        put :update, chapter_id: @chapter.id, id: @video.id, video: { title: "title new", description: "", video_url: "http://triedge.in/admin/assets/media_library/library_video/143495500620150501_171720_VP8.webm", chapter_id: @chapter.id }
        @video.reload
        expect(assigns(:video)).to be_present 
      end
    end
  end
  describe "DELETE #destroy" do
    before do
      @chapter = FactoryGirl.create(:chapter)
      @video = FactoryGirl.create(:video, chapter_id: @chapter.id )
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { delete :destroy, chapter_id: @chapter.id, id: @video.id }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { delete :destroy, chapter_id: @chapter.id, id: @video.id }
    end
    context "If user is loggedin as an admin" do
      login_admin
      it "redirects to the chapter show page" do
        delete :destroy, chapter_id: @chapter.id, id: @video.id
        expect(response).to redirect_to admin_chapter_path(@chapter.id)
      end
      it "deletes the video" do
        delete :destroy, chapter_id: @chapter.id, id: @video.id
        expect(@chapter.videos.count).to eq(0)
      end
      it "flashes a success message" do
        delete :destroy, chapter_id: @chapter.id, id: @video.id
        expect(flash[:success]).to be_present 
      end

    end
  end

end
