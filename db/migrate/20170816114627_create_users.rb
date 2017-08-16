class CreateUsers < ActiveRecord::Migration[5.1]
    def change
        create_table :users, id: false, primary_key: [:user_id] do |t|
            t.string :user_id, null: false
            t.string :password_salted, null: false

            t.timestamps
        end
    end
end
