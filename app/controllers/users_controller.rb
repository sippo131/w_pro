class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page],per_page: 20)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])

    @userskills = UserSkill.where(user_id: params[:id])
    uniq_skill_id_array  = @userskills.group(:skill_id).pluck(:skill_id)

    @skill_count_hash = {}
    uniq_skill_id_array.each do |skill_id|
      @skill_count_hash[skill_id] = @userskills.where(skill_id: skill_id).size
    end

    @skill_count_array = @skill_count_hash.sort {|(k1, v1), (k2, v2)| v2 <=> v1}

    @skill = Skill.new
    @userskill = UserSkill.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Wantedly Demo App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Successed to edit your account!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    uredirect_to(root_url) unless current_user?(@user)
  end

  def skill_1_count
    @userskill
  end

end
