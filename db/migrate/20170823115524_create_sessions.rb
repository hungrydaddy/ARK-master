class CreateSessions < ActiveRecord::Migration[5.1]
    def change
        create_table :sessions do |t|
            t.string :user_id, null: false
            t.string :session_id, null: false
            t.timestamps
        end
    end
end
