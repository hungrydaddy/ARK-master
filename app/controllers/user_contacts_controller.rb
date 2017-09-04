class UserContactsController < ApplicationController
    def new; end


    def create
        # check params
        unless params[:user_email]
            render json: { success: 'no', msg: 'no user email received' }
            return
        end
        unless params[:contact_email]
            render json: { success: 'no', msg: 'no contact email received' }
            return
        end



        unless User.exists?(email: params[:user_email])
            render json: { success: 'no', msg: 'user does not exist' }
            return
        end
        unless User.exists?(email: params[:contact_email])
            render json: { success: 'no', msg: 'contact does not exist' }
            return
        end
        if UserContact.exists?(user_id: User.find_by(email: params[:user_email]).user_id, contact_id: User.find_by(email: params[:contact_email]).user_id)
            render json: { success: 'no', msg: 'already in contact' }
            return
        end
        UserContact.create(user_id: User.find_by(email: params[:user_email]).user_id, contact_id: User.find_by(email: params[:contact_email]).user_id)
        render json: { success: 'ok', msg: 'contact created, done' }
    end


    def show
        # look up user contacts
        unless params[:email]
            render json: { success: 'no', msg: 'no email received' }
            return
        end
        unless User.exists?(user_id: params[:email])
            render json: { success: 'no', msg: 'user does not exist' }
            return
        end

        userId = User.find_by(email: params[:email]).user_id

        allContactIds = Array.new
        allContacts = UserContact.where(user_id: userId)
        allContacts.each do |contact|
            allContactIds.push(contact.contact_id)
        end

        render json: { success: 'ok', contacts: allContactIds }
    end


    def check
        # check params
        unless params[:user_email]
            render json: { success: 'no', msg: 'no user email received' }
            return
        end
        unless params[:contact_email]
            render json: { success: 'no', msg: 'no contact email received' }
            return
        end
        unless User.exists?(email: params[:user_email])
            render json: { success: 'no', msg: 'user does not exist' }
            return
        end
        unless User.exists?(email: params[:contact_email])
            render json: { success: 'no', msg: 'contact does not exist' }
            return
        end


        if UserContact.exists?(user_id: User.find_by(email: params[:user_email]).user_id, contact_id: User.find_by(email: params[:contact_email]).user_id)
            render json: { success: 'ok', msg: 'in contact' }
        else
            render json: { success: 'ok', msg: 'not in contact' }
        end
    end



    def destroy
        # check params
        unless params[:user_email]
            render json: { success: 'no', msg: 'no user email received' }
            return
        end
        unless params[:contact_email]
            render json: { success: 'no', msg: 'no contact email received' }
            return
        end
        unless User.exists?(email: params[:user_email])
            render json: { success: 'no', msg: 'user does not exist' }
            return
        end
        unless User.exists?(email: params[:contact_email])
            render json: { success: 'no', msg: 'contact does not exist' }
            return
        end

        if UserContact.exists?(user_id: User.find_by(email: params[:user_email]).user_id, contact_id: User.find_by(email: params[:contact_email]).user_id)
            UserContact.find_by(user_id: User.find_by(email: params[:user_email]).user_id, contact_id: User.find_by(email: params[:contact_email]).user_id).destroy
            render json: { success: 'ok', msg: 'contact deleted' }
        else
            render json: { success: 'no', msg: 'not in contact, cannot delete' }
        end
    end

end
