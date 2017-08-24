class CreateDirects < ActiveRecord::Migration[5.1]
    def change
        create_table :directs do |t|
            t.string :user1_id, null: false
            t.string :user2_id, null: false
            t.string :conversation_id, null: false

            t.timestamps
        end
    end
end
