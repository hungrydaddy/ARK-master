class CreateGroupProfiles < ActiveRecord::Migration[5.1]
    def change
        create_table :group_profiles do |t|
            t.string :group_id, null: false
            t.string :group_name, null: false

            t.timestamps
        end
    end
end
