class CreateExpenses < ActiveRecord::Migration
  def up
    create_table :expenses do |t|
      t.column :name, :string
      t.column :cost, :integer
      t.column :tag, :string

      t.timestamps
    end
  end

  def down
    drop_table :expenses
  end
end
