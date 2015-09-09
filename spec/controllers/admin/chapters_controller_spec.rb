require 'rails_helper'

describe Admin::ChaptersController do

  describe "GET #index" do
    before do
      @course = FactoryGirl.create(:course)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { get :index, course_id: @course.id }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { get :index, course_id: @course.id}
    end
    context "If user is loggedin as an admin" do
      login_admin
      it "sets the course" do
        get :index, course_id: @course.id
        expect(assigns(:course)).to eq(@course)
      end
      it "sets chapters to a particular course" do
        chapter1 = FactoryGirl.create(:chapter, course_id: @course.id)
        chapter2 = FactoryGirl.create(:chapter, course_id: @course.id)
        get :index, course_id: @course.id
        expect(assigns(:chapters)).to be_present 
      end
    end
  end
  describe "GET #show" do
    before do
      @course = FactoryGirl.create(:course)
      @chapter = FactoryGirl.create(:chapter, course_id: @course.id)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { get :show, course_id: @course.id, id: @chapter.id }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { get :show, course_id: @course.id, id: @chapter.id }
    end
    context "If user is loggedin as an admin" do
      login_admin
      it "renders the :show template" do
        get :show, course_id: @course.id, id: @chapter.id
        expect(response).to render_template :show
      end
      it "shows a chapter" do
        get :show, course_id: @course.id, id: @chapter.id
        expect(assigns(:chapter)).to be_present 
      end
    end
  end
  describe "GET #new" do
    before do
      @course = FactoryGirl.create(:course)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { get :new, course_id: @course.id }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { get :new, course_id: @course.id }
    end
    context "If user is loggedin as an admin" do
      login_admin
      it "sets the course to a new chapter" do
        get :new, course_id: @course.id
        expect(assigns(:chapter)).to be_instance_of(Chapter)
        expect(assigns(:chapter)).to be_new_record
      end
    end
    context "if user loggedin as a regular user" do
        login_user
          it "sets the flash error message" do
          #get :new
          #expect(flash[:alert]).to be_present
          expect{ get :new, course_id: @course.id }.to raise_error(CanCan::AccessDenied)
        end
    end
  end
  describe "POST #create" do
    before do
      @course = FactoryGirl.create(:course)
    end
      it_behaves_like "sign in mandatory" do
        let(:action) { post :create, course_id: @course.id }
      end
      it_behaves_like "admin mandatory" do
        let(:action) { post :create, course_id: @course.id }
      end
    context "with valid attributes" do
      login_admin
      it "redirects to the course show page" do
        post :create, chapter: { title: "workshop on IT Recruitment", description: "In this workshop, one will learn how they can do IT Recruitment", course_id: @course.id, tagline: "congratulations, you are a successfully completed your IT Recruitment Training", badge_image: "it_recuiter.jpg" }, course_id: @course.id
        expect(response).to redirect_to admin_course_path(@course.id)
      end
      it "creates a new chapter" do
        post :create, chapter: { title: "workshop on IT Recruitment", description: "In this workshop, one will learn how they can do IT Recruitment", course_id: @course.id, tagline: "congratulations, you are a successfully completed your IT Recruitment Training", badge_image: "it_recuiter.jpg" }, course_id: @course.id
        expect(Chapter.count).to eq(1) 
      end
      it "flashes a success message" do
         post :create, chapter: { title: "workshop on IT Recruitment", description: "In this workshop, one will learn how they can do IT Recruitment", course_id: @course.id, tagline: "congratulations, you are a successfully completed your IT Recruitment Training", badge_image: "it_recuiter.jpg" }, course_id: @course.id
        expect(flash[:success]).to be_present 
      end
    end
  end
  describe "PUT #update" do
    before do
      @course = FactoryGirl.create(:course)
      @chapter = FactoryGirl.create(:chapter, course_id: @course.id)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { post :update, course_id: @course.id, id: @chapter.id  }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { post :update, course_id: @course.id, id: @chapter.id  }
    end

    context "with valid attributes" do
      login_admin
      it "redirects to the course show page" do
        put :update, course_id: @course.id, id: @chapter.id, chapter: { title: "title new", description: @chapter.description, course_id: @chapter.course_id, tagline: @chapter.tagline, badge_image: @chapter.badge_image } 
        expect(response).to redirect_to admin_course_chapter_path(@chapter.course_id, @chapter.id)
      end
      it "updates the chapter" do
        put :update, course_id: @course.id, id: @chapter.id, chapter: { title: "title new", description: @chapter.description, course_id: @chapter.course_id, tagline: @chapter.tagline, badge_image: @chapter.badge_image } 
        @chapter.reload
        expect(@chapter.title).to eq("title new")
      end
      it "flashes success message" do
        put :update, course_id: @course.id, id: @chapter.id, chapter: { title: "title new", description: @chapter.description, course_id: @chapter.course_id, tagline: @chapter.tagline, badge_image: @chapter.badge_image } 
        expect(flash[:success]).to be_present
      end
    end
     context "with invalid attributes " do
      login_admin
      it "doesn't update the chapter" do
         put :update, course_id: @course.id, id: @chapter.id, chapter: { title: "title new", description: "", course_id: @chapter.course_id, tagline: @chapter.tagline, badge_image: @chapter.badge_image } 
        @chapter.reload
        expect(Chapter.find(@chapter.id).description).not_to eq("")
      end
      it "renders the edit page" do
         put :update, course_id: @course.id, id: @chapter.id, chapter: { title: "title new", description: "", course_id: @chapter.course_id, tagline: @chapter.tagline, badge_image: @chapter.badge_image } 
        expect(response).to render_template :edit 
      end
      it "flashes error message" do
        put :update, course_id: @course.id, id: @chapter.id, chapter: { title: "title new", description: "", course_id: @chapter.course_id, tagline: @chapter.tagline, badge_image: @chapter.badge_image } 
        expect(flash[:alert]).to be_present 
      end
      it "sets the @chapter" do
        put :update, course_id: @course.id, id: @chapter.id, chapter: { title: "title new", description: "", course_id: @chapter.course_id, tagline: @chapter.tagline, badge_image: @chapter.badge_image } 
        expect(assigns(:chapter)).to be_present 
      end
    end
  end
  describe "DELETE #destroy" do
    before do
      @course = FactoryGirl.create(:course)
      @chapter = FactoryGirl.create(:chapter, course_id: @course.id)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { delete :destroy, course_id: @course.id, id: @chapter.id  }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { delete :destroy, course_id: @course.id, id: @chapter.id  }
    end
    context "If user is loggedin as an admin" do
      login_admin
      it "redirects to the course show page" do
        delete :destroy, course_id: @chapter.course_id, id: @chapter.id
        expect(response).to redirect_to admin_course_path(@course.id)
      end
      it "deletes the chapter" do
        delete :destroy, course_id: @chapter.course_id, id: @chapter.id
        expect(@course.chapters.count).to eq(0)
      end
      it "flashes success message" do
        delete :destroy, course_id: @chapter.course_id, id: @chapter.id
        expect(flash[:success]).to be_present 
      end
    end
  end
end
