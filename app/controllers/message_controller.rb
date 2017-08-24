class MessageController < ApplicationController

    def create
        # check params
        if !params[:conversation_id] || !params[:message_body] || !params[:email]
            render json: { success: 'no', msg: 'not enough info' }
            return
        end
        unless User.exists?(email: params[:email])
            render json: { success: 'no', msg: 'user does not exist' }
            return
        end
        unless Direct.exists?(conversation_id: params[:conversation_id])
            render json: { success: 'no', msg: 'convo does not exist' }
            return
        end

        senderId = User.find_by(email: params[:email]).user_id
        Message.create(conversation_id: params[:conversation_id], sender_id: senderId, message_body: params[:message_body])

        render json: { success: 'ok', msg: 'msg sent' }
    end



    # show all msgs that belongs to a convo
    def show
        unless params[:conversation_id]
            render json: { success: 'no', msg: 'not enough info' }
            return
        end
        unless Direct.exists?(conversation_id: params[:conversation_id])
            render json: { success: 'no', msg: 'convo does not exist' }
            return
        end
        unless Message.exists?(conversation_id: params[:conversation_id])
            render json: { success: 'no', msg: 'no messages' }
            return
        end

        allMsgs = Array.new
        Message.where(conversation_id: params[:conversation_id]).find_each do |message|
            allMsgs.push(message)
        end

        render json: { success: 'ok', messageList: allMsgs }
    end

end
