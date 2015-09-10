require 'rails_helper'

describe Admin::QuestionsController do
  describe "GET #show" do
    before do
      @chapter = FactoryGirl.create(:chapter)
      @quiz = FactoryGirl.create(:quiz, chapter_id: @chapter.id)
      @question = FactoryGirl.create(:question, quiz_id: @quiz.id)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { get :show, quiz_id: @quiz.id, id: @question.id }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { get :show, quiz_id: @quiz.id, id: @question.id }
    end
    context "If user is loggedin as an admin" do
      login_admin
      it "renders the :show template" do
        get :show, quiz_id: @quiz.id, id: @question.id
        expect(response).to render_template :show
      end
      it "returns a question" do
        get :show, quiz_id: @quiz.id, id: @question.id
        expect(assigns(:question)).to be_present 
      end
      it "returns a question for the quiz" do
        get :show, quiz_id: @quiz.id, id: @question.id
        expect(assigns(:question).quiz_id).to eq(@question.quiz_id)
      end
    end
    context "with invalid user logged in" do
            it "redirects to the sign in page" do
             get :show, quiz_id: @quiz.id, id: @question.id
             expect(response).to redirect_to new_user_session_path
            end
        end
  end
  describe "GET #new" do
    before do
      @chapter = FactoryGirl.create(:chapter)
      @quiz = FactoryGirl.create(:quiz, chapter_id: @chapter.id)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { get :new, quiz_id: @quiz.id }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { get :new, quiz_id: @quiz.id }
    end
    context "If user is loggedin as an admin" do
      login_admin
      it "sets the question to a new question" do
        get :new, quiz_id: @quiz.id
        expect(assigns(:question)).to be_instance_of(Question)
        expect(assigns(:question)).to be_new_record
      end
      it "assigns a quiz to the question" do
        get :new, quiz_id: @quiz.id
        expect(assigns(:question).quiz_id).to eq(@quiz.id) 
      end
    end
    context "if user loggedin as a regular user" do
      login_user
      it "sets the flash error message" do
        expect{ get :new, quiz_id: @quiz.id }.to raise_error(CanCan::AccessDenied)
      end
     end
  end

  describe "POST #create" do
    before do
      @quiz = FactoryGirl.create(:quiz)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { get :new, quiz_id: @quiz.id }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { get :new, quiz_id: @quiz.id }
    end

    context "with valid attributes" do
      login_admin
      it "redirects to the quiz show page" do
        post :create, quiz_id: @quiz.id, question: { title: "team management", quiz_id: @quiz.id }
        expect(response).to redirect_to admin_quiz_path(@quiz.id)
      end
      it "creates a new question" do
        post :create, quiz_id: @quiz.id, question: { title: "team management", quiz_id: @quiz.id }
        expect(Question.count).to eq(1) 
      end
      it "flashes success message" do
        post :create, quiz_id: @quiz.id, question: { title: "team management", quiz_id: @quiz.id }
        expect(flash[:success]).to be_present 
      end
    end
    context "with invalid attributes" do
      login_admin
      it "renders the :new template" do
        post :create, quiz_id: @quiz.id, question: { title: "", quiz_id: @quiz.id }
        expect(response).to render_template :new
      end
      it "does not create a new question" do
        post :create, quiz_id: @quiz.id, question: { title: "", quiz_id: @quiz.id }
        expect(Question.count).to eq(0)
      end
      it "sets the @question variable" do
        post :create, quiz_id: @quiz.id, question: { title: "", quiz_id: @quiz.id }
        expect(assigns(:question)).to be_present 
      end
      it "flashes error message" do
        post :create, quiz_id: @quiz.id, question: { title: "", quiz_id: @quiz.id }
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "PUT #update" do
    before do
      @quiz = FactoryGirl.create(:quiz)
      @question = FactoryGirl.create(:question, quiz_id: @quiz.id)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { put :update, quiz_id: @quiz.id, id: @question.id }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { put :update, quiz_id: @quiz.id, id: @question.id }
    end
   context "with valid attributes" do
      login_admin
      it "redirects to the question show page" do
        put :update, quiz_id: @quiz.id, id: @question.id, question: { title: "title new" }
        expect(response).to redirect_to admin_quiz_question_path(@question.quiz_id, @question.id)
      end
      it "updates the question" do
        put :update, quiz_id: @quiz.id, id: @question.id, question: { title: "title new" }
        expect(assigns(:question).title).to eq("title new")
      end
      it "flashes success message" do
        put :update, quiz_id: @quiz.id, id: @question.id, question: { title: "title new" }
        expect(flash[:success]).to be_present
      end
    end
  end
  describe "DELETE #destroy" do
    before do
      @quiz = FactoryGirl.create(:quiz)
      @question = FactoryGirl.create(:question, quiz_id: @quiz.id)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { delete :destroy, quiz_id: @quiz.id, id: @question.id }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { delete :destroy, quiz_id: @quiz.id, id: @question.id }
    end
    context "If user is loggedin as an admin" do
      login_admin
      it "redirects to the quiz show page" do
        delete :destroy, quiz_id: @quiz.id, id: @question.id
        expect(response).to redirect_to admin_quiz_path(@quiz.id)
      end
      it "deletes the question" do
        delete :destroy, quiz_id: @quiz.id, id: @question.id
        expect(@quiz.questions.count).to eq(0)
      end
      it "flashes success message" do
        delete :destroy, quiz_id: @quiz.id, id: @question.id
        expect(flash[:success]).to be_present
      end
    end
  end
end
