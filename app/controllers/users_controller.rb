class UsersController < ApplicationController

	before_action :authenticate

	def index
		@users = User.all
	end
	
	def show
		@user = User.find(params[:id])
		@current_user = current_user
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to users_path
		else
			render :new
		end
	end

	def edit
		@user = User.find(params[:id])
		if @user != current_user
			redirect_to @user
		end
	end

	def update
		@user = User.find(params[:id])
		if @usser != current_user
			redirect_to users_path
		else
			if @user.update(user_params)
				redirect_to @user
			else
				redirect_to(edit_user_path(@user))
			end
		end
	end

	def destroy
		@user = User.find(params[:id])
		if @user != current_user
			redirect_to users_path
		else
			@user.destroy
			redirect_to(users_path)
		end
	end

	private 
	def user_params
		params.require(:user).permit(:username, :first_name, :last_name, :avatar, :password, :password_confirmation)
	end
end