class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.string :password_salt

      t.integer :admin_university_id
      t.integer :home_university_id
      t.integer :foreign_university_id
      t.integer :user_type_id

      t.timestamps
    end
  end
end
