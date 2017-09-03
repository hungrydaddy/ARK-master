class LocationsController < ApplicationController
    def update
        # check params
        if !params[:email] || !params[:lat] || !params[:lng]
            render json: { success: 'no', msg: 'not enough info' }
            return
        end
        unless User.exists?(email: params[:email])
            render json: { success: 'no', msg: 'user does not exist' }
            return
        end


        userId = User.find_by(email: params[:email]).user_id

        if !Location.exists?(user_id: userId)
            Location.create(user_id: userId, lat: params[:lat], lng: params[:lng])
        else
            oldLocation = Location.find_by(user_id: userId)
            oldLocation.lat = params[:lat]
            oldLocation.lng = params[:lng]
            oldLocation.save
        end

        render json: { success: 'ok', msg: 'location updated' }
    end


    def show
        # check params
        if !params[:email]
            render json: { success: 'no', msg: 'not enough info' }
            return
        end
        unless User.exists?(email: params[:email])
            render json: { success: 'no', msg: 'user does not exist' }
            return
        end

        userId = User.find_by(email: params[:email]).user_id
        if !Location.exists?(user_id: userId)
            render json: { success: 'no', msg: 'user does not have location info' }
            return
        else
            location = Location.find_by(user_id: userId)
            render json: { success: 'ok', location: location }
        end
    end

end
