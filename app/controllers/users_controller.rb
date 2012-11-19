class UsersController < ApplicationController

  def index
    @users = User.all
	respond_to do |format|
	  format.html
	  format.csv { send_data self.export_to_csv }
	end
  end

  def new
    if not current_user or not current_user.is_admin?
      flash[:notice] = "You must be an admin to create new accounts"
      redirect_to root_path
    end
    @user = User.new
  end
  
  def create
    user_info = params[:user]
    @user = User.new(user_info)
    if @user.save
      flash[:notice] = "New account successfully created"
      redirect_to users_path
    else
      flash[:error] = @user.errors.empty? ? "Error" : @user.errors.full_messages.to_sentence
      render new_user_path
    end
  end  


  def export_to_csv
    @users = User.find(:all)
    csv_string = CSV.generate do |csv|
      csv << ["type", "name", "email"]
      @users.each do |user|
        csv << [user.type, user.name, user.email]
      end 
    end
  end

end
