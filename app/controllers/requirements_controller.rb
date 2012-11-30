class RequirementsController < ApplicationController
  def index
    @requirements = Requirements.all
  end
  def edit
    @requirement = Requirements.find_by_grade(params[:id])
  end
  def update
    data = params[:requirements]
    @requirement = Requirements.find_by_grade(data[:grade])
    @requirement.hours = data[:hours]
    @requirement.save
    flash[:notice] = "Successfully updated"
    redirect_to requirements_path
  end
end
