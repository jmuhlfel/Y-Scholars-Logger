class Requirements < ActiveRecord::Base
  attr_accessible :grade, :hours
  # Validations
  validates :grade, :prescence => true, :uniqueness => true
  validates :hours, :prescence => true
end
