class DashboardController < ApplicationController
  def index
    @students = Student.all
  end
end
