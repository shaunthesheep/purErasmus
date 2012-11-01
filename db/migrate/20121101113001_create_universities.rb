class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      t.string :name_english
      t.string :name_original
      t.string :website
      t.string :contact

      t.timestamps
    end
  end
end
