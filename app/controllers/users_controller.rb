class UsersController < ApplicationController
    def new; end

    def create
        if !params[:email] || !params[:nick_name] || !params[:password_salted] || !params[:desription]
            render json: { success: 'no', msg: 'not enough info' }
            return
        end

        begin
            newUserId = ActiveSupport::SecureRandom.hex(32)
        end while !User.find_by(user_id: newUserId)

        newUser = User.create(user_id: newUserId, password_salted: params[:password_salted], email: params[:email])
        newProfile = UserProfile.create(user_id: newUserId, nick_name: params[:nick_name], desription: params[:desription])

        render json: { success: 'ok', user_id: newUserId }
    end




    def show
        unless params[:user_id]
            render json: { success: 'no', msg: 'no user id received' }
            return
        end

        if !User.find_by(user_id: params[:user_id])
            render json: { success: 'no', msg: 'user does not exist' }
        else
            render json: { success: 'ok', user_info: User.find_by(user_id: params[:user_id])}
        end
    end



    # delete the user
    def destroy
        target = User.find_by(user_id: params[:user_id])
        if !target
            render json: { success: 'no', msg: 'user does not exist' }
        else
            target.destroy
            render json: { success: 'ok' }
        end
    end


    # testing
    def test
        render json: { success: 'ok' }
    end
end
