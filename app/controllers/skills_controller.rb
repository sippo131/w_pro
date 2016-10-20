class SkillsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]
  autocomplete :skill, :name, :full => true

  def index
    @skills = Skill.paginate(page: params[:page],per_page: 20)
  end

  def show
    @skill = Skill.find(params[:id])
    @skill_users = @skill.users.paginate(page: params[:page],per_page: 20)
  end

  def create
    @skill = Skill.find_by(name: params[:skill][:name])
    @user = User.find(params[:user_id])

    if @skill.nil?
      # まだスキルが作られていない→Skill×,UserSkill×
      @skill = Skill.create(name: params[:skill][:name])
      UserSkill.create(user_id: @user.id, skill_id: @skill.id, tagged_user_id: current_user.id)
      flash[:success] = "Success to make new skill!"
      redirect_to @user

    else
      @userskill = UserSkill.find_by(user_id: @user.id, skill_id: @skill.id)


      if @userskill.nil?
        # Skill◯,UserSkill×
        UserSkill.create(user_id: @user.id, skill_id: @skill.id, tagged_user_id: current_user.id)
        flash[:success] = "Success to make new skill!"
        redirect_to @user
      else
        # Skill◯,UserSkill◯
        flash[:danger] = "Already made!"
        redirect_to @user
      end
    end
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

end
