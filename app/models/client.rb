class Client < ApplicationRecord
  has_many :projects
  validates_presence_of :name

  def as_json options={}
    {
        id: id,
        name: name,
        creation_time: created_at,
        updation_time: updated_at,
        projects: projects.as_json
    }
  end
end
