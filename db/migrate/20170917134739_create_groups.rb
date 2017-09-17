class CreateGroups < ActiveRecord::Migration[5.1]
    def change
        create_table :groups do |t|
            t.string :group_id, null: false
            t.string :user_id, null: false
            t.string :conversation_id, null: false

            t.timestamps
        end
    end
end
