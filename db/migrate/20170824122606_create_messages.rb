class CreateMessages < ActiveRecord::Migration[5.1]
    def change
        create_table :messages do |t|
            t.string :conversation_id, null: false
            t.string :sender_id, null: false
            t.text :message_body, null: false

            t.timestamps
        end
    end
end
