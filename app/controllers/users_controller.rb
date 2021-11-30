class UsersController < ApplicationController
  layout 'simple'

  before_action :set_default_country, only: %i[new create show edit update destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @profile = @user.build_profile
  end

  def show
    @users = User.find(params[:id])
    @profile = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @profile = @user.build_profile(profile_params)

    if @user.save
      redirect_to users_url
    else
      @cities = City.country_id(@user.country_id)
      render :new
    end
  end


  def edit
    @user = User.find(params[:id])
    @profile = Profile.find_by(user_id: params[:id])
  end

  def update
    @user = User.find(params[:id])
    @profile = Profile.find_by(user_id: params[:id])

    if @user.update(user_params) || @profile.update(profile_params)
      redirect_to @user
    else
      redirect_to edit_user_path
    end
  end

  def destroy
    @user = User.find(params[:id]).destroy
  end


  private

  def set_default_country
    @countries = Country.all
    @cities = []
  end

  def user_params
    params.require(:user).permit(:email, :username, :pin, :terms_of_use, :country_id, :city_id)
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :phone_number, :birth_date, :about_me)
  end
end