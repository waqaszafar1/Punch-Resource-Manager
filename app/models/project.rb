class Project < ApplicationRecord
  belongs_to :client, optional: true
  has_many :project_employee_mappings , dependent: :destroy
  has_many :employees , through: :project_employee_mappings
  validates_presence_of :title

  def as_json options={}
      {
          id: id,
          name: title,
          creation_time: created_at,
          updation_time: updated_at,
          employees: employees.map{|map| {id: map.id,name: map.name,designation:
              map.designation} }
      }
  end
end
