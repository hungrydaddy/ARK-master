class UsersController < ApplicationController
    def new; end

    def create
        if !params[:email] || !params[:nick_name] || !params[:password_salted] || !params[:description]
            render json: { success: 'no', msg: 'not enough info' }
            return
        end

        if User.exists?(email: params[:email])
            render json: { success: 'no', msg: 'email already used' }
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
            render json: { success: 'no', msg: 'user does not exist, cannot delete' }
        else
            User.find_by(user_id: params[:user_id]).destroy
            render json: { success: 'ok', msg: 'user deleted' }
        end
    end


    # testing
    def test
        render json: { success: 'ok' }
    end



    def login
        if !params[:email] || !params[:password_salted]
            render json: { success: 'no', msg: 'not enough info' }
            return
        end
        unless User.exists?(email: params[:email])
            render json: { success: 'no', msg: 'user does not exist' }
            return
        end
        unless User.exists?(email: params[:email], password_salted: params[:password_salted])
            render json: { success: 'no', msg: 'password not right' }
            return
        end

        # if all info right
        userId = User.find_by(email: params[:email], password_salted: params[:password_salted]).user_id
        newSessionId = SecureRandom.hex(16)

        if Session.exists?(user_id: userId)
            oldSession = Session.find_by(user_id: userId)
            oldSession.session_id = newSessionId
            oldSession.save
        else
            Session.create(user_id: userId, session_id: newSessionId)
        end

        render json: { success: 'ok', session_id: newSessionId, msg: 'info correct, log in' }
    end


    def check
        if !params[:email] || !params[:session_id]
            render json: { success: 'no', msg: 'not enough info' }
            return
        end
        unless User.exists?(email: params[:email])
            render json: { success: 'no', msg: 'user does not exist' }
            return
        end

        userId = User.find_by(email: params[:email]).user_id
        unless Session.exists?(user_id: userId, session_id: params[:session_id])
            render json: { success: 'no', msg: 'session expired' }
            return
        end

        render json: { success: 'ok', msg: 'login valid' }
    end

end
