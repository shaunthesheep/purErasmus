class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
    	t.string :title
    	t.text :body

    	t.integer :city_id
    	t.integer :university_id
    	t.integer :page_type_id

      	t.timestamps
    end
  end
end
