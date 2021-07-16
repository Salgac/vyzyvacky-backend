class AddAgeToPeople < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :age, :integer
  end
end
