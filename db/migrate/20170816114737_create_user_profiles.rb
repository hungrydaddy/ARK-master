class CreateUserProfiles < ActiveRecord::Migration[5.1]
    def change
        create_table :user_profiles, id: false, primary_key: [:user_id] do |t|
            t.string :user_id, null: false
            t.string :nick_name, null: false
            t.text :desription

            t.timestamps
        end
    end
end
