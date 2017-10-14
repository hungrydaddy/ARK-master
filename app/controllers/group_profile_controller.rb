class GroupProfileController < ApplicationController
    def show
        if !params[:group_id]
            render json: { success: 'no', msg: 'not enough info' }
            return
        end
        if !GroupProfile.exists?(group_id: params[:group_id])
            render json: { success: 'no', msg: 'group not exist' }
            return
        end

        render json: { success: 'ok', profile: GroupProfile.find_by(group_id: params[:group_id]) }
    end
end
