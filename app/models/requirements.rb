class Requirements < ActiveRecord::Base
  attr_accessible :grade, :hours
  # Validations
  validates :grade, :presence => true, :uniqueness => true
  validates :hours, :presence => true
end
