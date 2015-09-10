require 'spec_helper'

describe Admin::AnswersController do
  describe "GET #show" do
    before do
      @quiz = Fabricate(:quiz)
      @question = Fabricate(:question, quiz_id: @quiz.id)
      @answer = Fabricate(:answer, question_id: @question.id)
    end
    it_behaves_like "requires sign in" do
      let(:action) { get :show, question_id: @question.id, id: @answer.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { get :show, question_id: @question.id, id: @answer.id }
    end

    context "with valid user" do
      it "renders the :show template" do
        set_current_admin
        get :show, question_id: @question.id, id: @answer.id
        expect(response).to render_template :show
      end
      it "returns an answer" do
        set_current_admin
        get :show, question_id: @question.id, id: @answer.id
        expect(assigns(:answer)).to be_present
      end
      it "returns a answer for the question" do
        set_current_admin
        get :show, question_id: @question.id, id: @answer.id
        expect(assigns(:answer).question_id).to eq(@answer.question_id)
      end
    end
    context "with invalid user" do
      it "redirects to the sign in page" do
        get :show, question_id: @question.id, id: @answer.id
        expect(response).to redirect_to sign_in_path
      end
    end
  end
  describe "GET #new" do
    before do
      @quiz = Fabricate(:quiz)
      @question = Fabricate(:question, quiz_id: @quiz.id)
      @answer = Fabricate(:answer, question_id: @question.id)
    end
    it_behaves_like "requires sign in" do
      let(:action) { get :new, question_id: @question.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { get :new, question_id: @question.id }
    end

    it "sets the answer to a new answer" do
      set_current_admin
      get :new, question_id: @question.id
      expect(assigns(:answer)).to be_instance_of(Answer)
      expect(assigns(:answer)).to be_new_record
    end
    it "assigns a question to the answer" do
      set_current_admin
      get :new, question_id: @question.id
      expect(assigns(:answer).question_id).to eq(@question.id)
    end
    it "sets the flash error message for regular user" do
      set_current_user
      get :new, question_id: @question.id
      expect(flash[:alert]).to be_present
    end
  end

  describe "POST #create" do
    before do
      @quiz = Fabricate(:quiz)
      @question = Fabricate(:question, quiz_id: @quiz.id)
    end
    it_behaves_like "requires sign in" do
      let(:action) { post :create, question_id: @question.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { post :create, question_id: @question.id }
    end

    context "with valid input" do
      it "redirects to the question show page" do
        set_current_admin
        post :create, question_id: @question.id, answer: { title: "David Heinemeier Hanson", is_correct: true }
        expect(response).to redirect_to admin_quiz_question_path(@quiz.id, @question.id)
      end
      it "creates a new answer" do
        set_current_admin
        post :create, question_id: @question.id, answer: { title: "david heinemeier hanson", is_correct: true, feedback: "this is feedback" }
        expect(Answer.count).to eq(1)
      end
      it "sets the feedback" do
        set_current_admin
        post :create, question_id: @question.id, answer: { title: "David Heinemeier Hanson", is_correct: true, feedback: "this is feedback" }
        expect(Answer.first.feedback).to eq("this is feedback") 
      end
      it "sets the flash success message" do
        set_current_admin
        post :create, question_id: @question.id, answer: { title: "David Heinemeier Hanson", is_correct: true }
        expect(flash[:success]).to be_present
      end
      it "set the property is_correct" do
        set_current_admin
        post :create, question_id: @question.id, answer: { title: "David Heinemeier Hanson", correct: true }
        expect(assigns(:answer).correct?).to be_true
      end
    end
    context "with invalid input" do
      it "renders the :new template" do
        set_current_admin
        post :create, question_id: @question.id, answer: { title: "", correct: true }
        expect(response).to render_template :new
      end
      it "does not create a new answer" do
        set_current_admin
        post :create, question_id: @question.id, answer: { title: "", correct: true }
        expect(Answer.count).to eq(0)
      end
      it "sets the @answer variable" do
        set_current_admin
        post :create, question_id: @question.id, answer: { title: "", correct: true} 
        expect(assigns(:answer)).to be_present

      end
      it "sets the flash error message" do
        set_current_admin
        post :create, question_id: @question.id, answer: { title: "", correct: true} 
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "PUT #update" do
    before do
      @quiz = Fabricate(:quiz)
      @question = Fabricate(:question, quiz_id: @quiz.id)
      @answer = Fabricate(:answer, question_id: @question.id)
    end
    it_behaves_like "requires sign in" do
      let(:action) { put :update, question_id: @question.id, id: @answer.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { put :update, question_id: @question.id, id: @answer.id }
    end
    context "with valid input" do
      it "redirects to the answer show page" do
        set_current_admin
        put :update, question_id: @question.id, id: @answer.id, answer: { title: "new title", is_correct: true }
        expect(response).to redirect_to admin_question_answer_path(@question.id, @answer.id)
      end
      it "updates the answer" do
        set_current_admin
        put :update, question_id: @question.id, id: @answer.id, answer: { title: "new title", is_correct: true, feedback: "this is feedback" }
        expect(assigns(:answer).title).to eq("new title")
      end
      it "updates the answer's feedback" do
        set_current_admin
        put :update, question_id: @question.id, id: @answer.id, answer: { title: "new title", is_correct: true, feedback: "this is feedback" }
        expect(assigns(:answer).feedback).to eq("this is feedback")
      end
      it "sets the flash success message" do
        set_current_admin
        put :update, question_id: @question.id, id: @answer.id, answer: { title: "new title", is_correct: true }
        expect(flash[:success]).to be_present
      end
    end
    context "with invalid input" do
      it "renders the :edit template" do
        set_current_admin
        put :update, question_id: @question.id, id: @answer.id, answer: { title: "", correct: true }
        expect(response).to render_template :edit
      end
      it "does not update the answer" do
        set_current_admin
        put :update, question_id: @question.id, id: @answer.id, answer: { title: "", correct: true }
        @answer.reload
        expect(@answer.title).not_to eq("")
      end
      it "sets a flash error message" do
        set_current_admin
        put :update, question_id: @question.id, id: @answer.id, answer: { title: "", correct: true }
        expect(flash[:alert]).to be_present
      end
      it "sets the @answer" do
        set_current_admin
        put :update, question_id: @question.id, id: @answer.id, answer: { title: "", correct: true }
        expect(assigns(:answer)).to be_present
      end
    end
  end
  describe "DELETE #destroy" do
    before do
      @question = Fabricate(:question)
      @answer = Fabricate(:answer, question_id: @question.id)
    end
    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, question_id: @question.id, id: @answer.id }
    end
    it_behaves_like "requires admin" do
      let(:action) { delete :destroy, question_id: @question.id, id: @answer.id }
    end
    it "redirects to the question show page" do
      set_current_admin
      delete :destroy, question_id: @question.id, id: @answer.id
      expect(response).to redirect_to admin_question_path(@question.id)
    end
    it "deletes the answer" do
      set_current_admin
      delete :destroy, question_id: @question.id, id: @answer.id
      expect(@question.answers.count).to eq(0)
    end
    it "sets the flash success message" do
      set_current_admin
      delete :destroy, question_id: @question.id, id: @answer.id
      expect(flash[:success]).to be_present
    end
  end
end
