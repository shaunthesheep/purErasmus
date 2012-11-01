class CreatePageTypeCities < ActiveRecord::Migration
  def change
    create_table :page_type_cities do |t|
      t.string :name

      t.timestamps
    end
  end
end
