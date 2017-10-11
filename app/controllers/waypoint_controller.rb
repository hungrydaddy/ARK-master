class WaypointController < ApplicationController
    def create
        if !params[:email] || !params[:lat] || !params[:lng] || !params[:group_id] || !params[:active] || !params[:place_name] || !params[:place_address]
            render json: { success: 'no', msg: 'not enough info' }
            return
        end
        if !User.exists?(email: params[:email])
            render json: { success: 'no', msg: 'user not exist' }
            return
        end
        if !Group.exists?(group_id: params[:group_id])
            render json: { success: 'no', msg: 'group does not exist' }
            return
        end

        userId = User.find_by(email: params[:email]).user_id

        if !Group.exists?(group_id: params[:group_id], user_id: userId)
            render json: { success: 'no', msg: 'user not in this group' }
            return
        end

        oldWaypoint = Waypoint.find_by(group_id: params[:group_id])

        if oldWaypoint != nil
            oldWaypoint.destroy
        end

        userNickname = UserProfile.find_by(user_id: userId).nick_name
        newWaypoint = Waypoint.create(group_id: params[:group_id], creator_id: userId, lat: params[:lat], lng: params[:lng], active: params[:active], place_name: params[:place_name], place_address: params[:place_address])
        output = { :waypoint => newWaypoint, :creator_nickname => userNickname }
        render json: { success: 'ok', waypoint: output }
        return
    end




    def show
        if !params[:group_id]
            render json: { success: 'no', msg: 'not enough info' }
            return
        end
        if !Group.exists?(group_id: params[:group_id])
            render json: { success: 'no', msg: 'group does not exist' }
            return
        end
        if !Waypoint.exists?(group_id: params[:group_id])
            render json: { success: 'no', msg: 'group does not have waypoint yet' }
            return
        end

        groupWaypoint = Waypoint.find_by(group_id: params[:group_id])
        userId = groupWaypoint.creator_id
        userNickname = UserProfile.find_by(user_id: userId).nick_name
        output = { :waypoint => groupWaypoint, :creator_nickname => userNickname }
        render json: { success: 'ok', waypoint: output }
        return
    end

end
