class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    if policy(:user).isUserman?|| policy(:user).isAdmin?
      @users=User.page(params[:page])
    end
    if policy(:user).isSupervisor?
      @users=current_user.childs.page(params[:page])
    end
  end

  def show
  end

  def new
    @user = User.new
    @roles = Role.all
  end

  def edit
    @roles = Role.all
  end

  def create
    if params[:password].present?
      params[:user][:password] ||= params[:password]
    end


    @user = User.new(user_params)
    if params[:user][:parent].blank?
      @user.parent= current_user
    end
    unless params[:user][:roles].blank?
      params[:user][:roles].each do |role|
        @user.add_role role
      end
    end
    # @user.creator = current_user if current_user.present?

    respond_to do |format|
      if @user.save
        format.html { redirect_to [:admin, @user], notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        @roles = Role.all
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|


      result = false


      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        result = @user.update_without_password(user_params)
      else
        result = @user.update(user_params)
      end


      if result
        Role.all.each do |role|
          @user.revoke role.name
        end

        unless params[:user][:roles].blank?
          params[:user][:roles].each do |role|
            @user.add_role role
          end
        end
        format.html { redirect_to [:admin, @user], notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        @roles = Role.all
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :mobile, :email, :parent, :password, :password_confirmation)
  end
end
