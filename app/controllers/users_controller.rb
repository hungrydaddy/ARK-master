class UsersController < ApplicationController
    def new; end

    def create
        if !params[:email] || !params[:nick_name] || !params[:password_salted] || !params[:description]
            render json: { success: 'no', msg: 'not enough info' }
            return
        end

        begin
            newUserId = SecureRandom.hex(16)
        end while User.exists?(user_id: newUserId)

        newUser = User.create(user_id: newUserId, password_salted: params[:password_salted], email: params[:email])
        newProfile = UserProfile.create(user_id: newUserId, nick_name: params[:nick_name], description: params[:description])

        render json: { success: 'ok', user_id: newUserId }
    end




    def show
        unless params[:user_id]
            render json: { success: 'no', msg: 'no user id received' }
            return
        end

        if !User.exists?(user_id: params[:user_id])
            render json: { success: 'no', msg: 'user does not exist' }
        else
            render json: { success: 'ok', user_info: User.find_by(user_id: params[:user_id])}
        end
    end



    # delete the user
    def destroy
        unless params[:user_id]
            render json: { success: 'no', msg: 'no user id received' }
            return
        end

        if !User.exists?(user_id: params[:user_id])
            render json: { success: 'no', msg: 'user does not exist' }
        else
            User.find_by(user_id: params[:user_id]).destroy
            render json: { success: 'ok' }
        end
    end


    # testing
    def test
        render json: { success: 'ok' }
    end
end
