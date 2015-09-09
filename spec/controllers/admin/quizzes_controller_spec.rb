require 'rails_helper'

describe Admin::QuizzesController do
  describe "GET #show" do
    before do
      @chapter = FactoryGirl.create(:chapter)
      @quiz = FactoryGirl.create(:quiz, chapter_id: @chapter.id)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { get :show, chapter_id: @chapter.id, id: @quiz.id }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { get :show, chapter_id: @chapter.id, id: @quiz.id }
    end
    context "If user is loggedin as an admin" do
      login_admin
      it "renders the :show template" do
        get :show, chapter_id: @chapter.id, id: @quiz.id
        expect(response).to render_template :show
      end
      it "returns a quiz" do
        get :show, chapter_id: @chapter.id, id: @quiz.id
        expect(assigns(:quiz)).to be_present 
      end
      it "returns a quiz for a particular chapter" do
        get :show, chapter_id: @chapter.id, id: @quiz.id
        expect(assigns(:quiz).chapter_id).to eq(@quiz.chapter_id) 
      end
    end
    
  end
  describe "GET #new" do
    before do
      @chapter = FactoryGirl.create(:chapter)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { get :new, chapter_id: @chapter.id }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { get :new, chapter_id: @chapter.id }
    end
    context "If user is loggedin as an admin" do
      login_admin
      it "sets the quiz to a new quiz" do
        get :new, chapter_id: @chapter.id
        expect(assigns(:quiz)).to be_instance_of(Quiz)
        expect(assigns(:quiz)).to be_new_record
      end
      it "assigns a chapter to the quiz" do
        get :new, chapter_id: @chapter.id
        expect(assigns(:quiz).chapter_id).to eq(@chapter.id) 
      end
    end
    context "if user loggedin as a regular user" do
      login_user
      it "sets the flash error message" do
        expect{ get :new, chapter_id: @chapter.id }.to raise_error(CanCan::AccessDenied)
      end
    end
    context "If chapter already has a quiz" do
      login_admin
      it "sets an error message" do
        quiz2 = FactoryGirl.create(:quiz, chapter_id: @chapter.id)
        get :new, chapter_id: @chapter.id
        expect(flash[:alert]).to be_present 
      end
      it "redirects to the chapter show page" do
        quiz2 = FactoryGirl.create(:quiz, chapter_id: @chapter.id)
        get :new, chapter_id: @chapter.id
        expect(response).to redirect_to admin_chapter_path(@chapter.id)
      end
    end
  end
  describe "POST #create" do
    before do
      @chapter = FactoryGirl.create(:chapter)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { get :new, chapter_id: @chapter.id }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { get :new, chapter_id: @chapter.id }
    end

   context "with valid attributes" do
      login_admin
      it "redirects to the chapter show page" do
        post :create, chapter_id: @chapter.id, quiz: { title: "workshop on IT Recruitment", chapter_id: @chapter.id }
        expect(response).to redirect_to admin_chapter_path(@chapter.id)
      end
      it "creates a new quiz" do
        post :create, chapter_id: @chapter.id, quiz: { title: "workshop on IT Recruitment", chapter_id: @chapter.id }
        expect(Quiz.count).to eq(1) 
      end
      it "flashes a success message" do
        post :create, chapter_id: @chapter.id, quiz: { title: "workshop on IT Recruitment", chapter_id: @chapter.id }
        expect(flash[:success]).to be_present 

      end
    end
    context "with invalid attributes " do
      login_admin
      it "doesn't create a new quiz" do
        post :create, chapter_id: @chapter.id, quiz: { title: "", chapter_id: @chapter.id }
        expect(Quiz.count).to eq(0) 

      end
      it "renders the :new template" do
        post :create, chapter_id: @chapter.id, quiz: { title: "", chapter_id: @chapter.id }
        expect(response).to render_template :new 
      end
      it "sets the quiz variable" do
        post :create, chapter_id: @chapter.id, quiz: { title: "", chapter_id: @chapter.id }
        expect(assigns(:quiz)).to be_present 
      end
      it "sets the flash error message" do
        post :create, chapter_id: @chapter.id, quiz: { title: "", chapter_id: @chapter.id }
        expect(flash[:alert]).to be_present 
      end
    end
  end
  describe "PUT #update" do
    before do
      @chapter = FactoryGirl.create(:chapter)
      @quiz = FactoryGirl.create(:quiz, chapter_id: @chapter.id)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { put :update, chapter_id: @chapter.id, id: @quiz.id }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { put :update, chapter_id: @chapter.id, id: @quiz.id }
    end
    context "with valid attributes" do
      login_admin
      it "redirects to the quiz show page" do
        put :update, chapter_id: @chapter.id, id: @quiz.id, quiz: { title: "the safe workplace quiz", chapter_id: @chapter.id }
        expect(response).to redirect_to admin_chapter_quiz_path(@chapter.id, @quiz.id)
      end
      it "updates the quiz" do
        put :update, chapter_id: @chapter.id, id: @quiz.id, quiz: { title: "the safe workplace quiz", chapter_id: @chapter.id }
        @quiz.reload
        expect(@quiz.title).to eq("the safe workplace quiz")
      end
      it "sets the flash success message" do
        put :update, chapter_id: @chapter.id, id: @quiz.id, quiz: { title: "the safe workplace quiz", chapter_id: @chapter.id }
        expect(flash[:success]).to be_present
      end
    end
    context "with invalid attributes " do
      login_admin
      it "renders the edit page" do
        put :update, chapter_id: @chapter.id, id: @quiz.id, quiz: { title: "", chapter_id: @chapter.id }
        expect(response).to render_template :edit 
      end
      it "doesn't update the quiz" do
        put :update, chapter_id: @chapter.id, id: @quiz.id, quiz: { title: "", chapter_id: @chapter.id }
        @quiz.reload
        expect(@quiz.title).not_to eq("") 
      end
      it "flashes error message" do
        put :update, chapter_id: @chapter.id, id: @quiz.id, quiz: { title: "", chapter_id: @chapter.id }
        expect(flash[:alert]).to be_present
      end
      it "sets the quiz" do
        put :update, chapter_id: @chapter.id, id: @quiz.id, quiz: { title: "", chapter_id: @chapter.id }
        expect(assigns(:quiz)).to be_present
      end
    end
  end
  describe "DELETE #destroy" do
    before do
      @chapter = FactoryGirl.create(:chapter)
      @quiz = FactoryGirl.create(:quiz, chapter_id: @chapter.id)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { delete :destroy, chapter_id: @chapter.id, id: @quiz.id }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { delete :destroy, chapter_id: @chapter.id, id: @quiz.id }
    end

  context "If user is loggedin as an admin" do
      login_admin
     it "redirects to the chapter show page" do
       delete :destroy, chapter_id: @chapter.id, id: @quiz.id
       expect(response).to redirect_to admin_chapter_path(@chapter.id)
     end
     it "deletes the quiz" do
       delete :destroy, chapter_id: @chapter.id, id: @quiz.id
       expect(@chapter.quiz.present?).to be false
     end
     it "sets the flash success message" do
       delete :destroy, chapter_id: @chapter.id, id: @quiz.id
       expect(flash[:success]).to be_present 
     end
    end
  end

end
