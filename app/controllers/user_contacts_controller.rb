class UserContactsController < ApplicationController
    def new; end


    def create
        # check params
        unless params[:user_id]
            render json: { success: 'no', msg: 'no user id received' }
            return
        end
        unless params[:contact_id]
            render json: { success: 'no', msg: 'no contact id received' }
            return
        end



        unless User.exists?(user_id: params[:user_id])
            render json: { success: 'no', msg: 'user does not exist' }
            return
        end
        unless User.exists?(user_id: params[:contact_id])
            render json: { success: 'no', msg: 'contact does not exist' }
            return
        end
        if UserContact.exists?(user_id: params[:user_id], contact_id: params[:contact_id])
            render json: { success: 'no', msg: 'already in contact' }
            return
        end

        UserContact.create(user_id: params[:user_id], contact_id: params[:contact_id])
        render json: { success: 'ok' }
    end


    def show
        # look up user contacts
        unless params[:user_id]
            render json: { success: 'no', msg: 'no user id received' }
            return
        end

        allContactIds = Array.new
        allContacts = UserContact.where(user_id: params[:user_id])
        allContacts.each do |contact|
            allContactIds.push(contact.contact_id)
        end

        render json: { success: 'ok', contacts: allContactIds }
    end


    def check
        # check params
        unless params[:user_id]
            render json: { success: 'no', msg: 'no user id received' }
            return
        end
        unless params[:contact_id]
            render json: { success: 'no', msg: 'no contact id received' }
            return
        end
        unless User.exists?(user_id: params[:user_id])
            render json: { success: 'no', msg: 'user does not exist' }
            return
        end
        unless User.exists?(user_id: params[:contact_id])
            render json: { success: 'no', msg: 'contact does not exist' }
            return
        end


        if UserContact.exists?(user_id: params[:user_id], contact_id: params[:contact_id])
            render json: { success: 'ok', msg: 'in contact' }
        else
            render json: { success: 'no', msg: 'not in contact' }
        end
    end
end
