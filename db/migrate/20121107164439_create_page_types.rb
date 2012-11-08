class CreatePageTypes < ActiveRecord::Migration
  def change
    create_table :page_types do |t|
      t.string :name
      t.boolean :is_mandatory
      t.integer :type      

      t.timestamps
    end
  end
end
