class CreateWaypoints < ActiveRecord::Migration[5.1]
    def change
        create_table :waypoints do |t|
            t.string :active, null: false
            t.string :group_id, null: false
            t.string :creator_id, null: false
            t.float :lat, null: false
            t.float :lng, null: false
            t.string :place_name, null: false
            t.string :place_address. null: false

            t.timestamps
        end
    end
end
