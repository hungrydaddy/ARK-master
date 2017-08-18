class CreateUserContacts < ActiveRecord::Migration[5.1]
    def change
        create_table :user_contacts do |t|
            t.string :user_id, null: false
            t.string :contact_id, null: false

            t.timestamps
        end
    end
end
