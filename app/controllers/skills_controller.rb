class SkillsController < ApplicationController

  def index
    @skills = Skill.paginate(page: params[:page],per_page: 20)
  end

  def show
    @skill = Skill.find(params[:id])
    @skill_users = @skill.users.paginate(page: params[:page],per_page: 20)
  end

end
