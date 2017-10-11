class DropWaypoint < ActiveRecord::Migration[5.1]
    def up
        drop_table :waypoints
    end
end
