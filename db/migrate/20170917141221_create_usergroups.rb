class CreateUsergroups < ActiveRecord::Migration[5.1]
    def change
        create_table :usergroups do |t|
            t.string :user_id, null: false
            t.string :group_id, null: false

            t.timestamps
        end
    end
end
