class CreateProjectEmployeeMappings < ActiveRecord::Migration[5.1]
  def change
    create_table :project_employee_mappings do |t|
      t.references :employee, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
