class TutorsController < ApplicationController

  def index
    @tutors = Tutor.all
  end

end