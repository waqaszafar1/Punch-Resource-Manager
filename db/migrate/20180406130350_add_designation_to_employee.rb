class AddDesignationToEmployee < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :designation, :string
  end
end
