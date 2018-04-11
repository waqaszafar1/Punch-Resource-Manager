class Employee < ApplicationRecord
  has_many :project_employee_mappings , dependent: :destroy
  has_many :projects, through: :project_employee_mappings
  validates_presence_of :name , :designation
end
