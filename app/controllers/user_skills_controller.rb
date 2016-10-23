class UserSkillsController < ApplicationController

  def create
    @userskill = UserSkill.find_by(user_id: params[:user_id], skill_id: params[:skill_id], tagged_user_id: current_user.id)
    @user = User.find(params[:user_id])

    if @userskill.nil?
      UserSkill.create(user_id: params[:user_id], skill_id: params[:skill_id], tagged_user_id: current_user.id)
      redirect_to @user
    else

      @userskill.destroy
      redirect_to @user
    end
  end

end
