class CreatePageTypeUniversities < ActiveRecord::Migration
  def change
    create_table :page_type_universities do |t|
      t.string :name
      t.boolean :is_mandatory

      t.timestamps
    end
  end
end
