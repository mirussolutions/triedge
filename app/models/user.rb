class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

     has_many :responses
	 has_many :answers, through: :responses
	 has_many :quiz_completions
	 has_many :quizzes, through: :quiz_completions
	 has_many :watches
	 has_many :videos, through: :watches


  private
  after_create :assign_default_role

  def assign_default_role
    add_role(:student) if self.roles.blank?
  end

end
