class UsersController < ApplicationController
    def new; end

    def create
        begin
            newUserId = ActiveSupport::SecureRandom.hex(32)
        end while !User.find_by(user_id: newUserId)

        newUser = User.create(user_id: newUserId, password_salted: params[:password_salted])
        newProfile = UserProfile.create(user_id: newUserId, nick_name: params[:nick_name], desription: params[:desription])

        render json: { success: 'ok' }
    end

    def show
        unless params[:user_id]
            render json: { success: 'no', msg: 'no user id received' }
            return
        end

        if !User.find_by(user_id: params[:user_id])
            render json: { success: 'no', msg: 'user does not exist' }
        else
            render json: User.find_by(user_id: params[:user_id])
        end
    end

    def test
        render json: { success: 'ok' }
    end
end
