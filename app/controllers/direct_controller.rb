class DirectController < ApplicationController
    def show
        # check params
        unless params[:email]
            render json: { success: 'no', msg: 'not enough info' }
            return
        end
        unless User.exists?(email: params[:email])
            render json: { success: 'no', msg: 'user does not exist' }
            return
        end


        userId = User.find_by(email: params[:email]).user_id
        allDirects = Array.new
        Direct.where(user1_id: userId).find_each do |direct|
            otherUserId = direct.user2_id
            otherUserNickname = UserProfile.find_by(user_id: otherUserId).nick_name

            if Message.exists?(conversation_id: direct.conversation_id)
                lastMsg = Message.where(conversation_id: direct.conversation_id).last.message_body
                time = Message.where(conversation_id: direct.conversation_id).last.updated_at
            else
                lastMsg = nil
                time = nil
            end

            output = { :conversation_id => direct.conversation_id, :other_nickname => otherUserNickname, :time => time, :lastMsg => lastMsg }
            allDirects.push(output)
        end
        Direct.where(user2_id: userId).find_each do |direct|
            otherUserId = direct.user1_id
            otherUserNickname = UserProfile.find_by(user_id: otherUserId).nick_name

            if Message.exists?(conversation_id: direct.conversation_id)
                lastMsg = Message.where(conversation_id: direct.conversation_id).last.message_body
                time = Message.where(conversation_id: direct.conversation_id).last.updated_at
            else
                lastMsg = nil
                time = nil
            end

            output = { :conversation_id => direct.conversation_id, :other_nickname => otherUserNickname, :time => time, :lastMsg => lastMsg }
            allDirects.push(output)
        end


        allGroups = Array.new
        Group.where(user_id: userId).find_each do |group|
            if Message.exists?(conversation_id: group.conversation_id)
                lastMsg = Message.where(conversation_id: group.conversation_id).last.message_body
                time = Message.where(conversation_id: group.conversation_id).last.updated_at
            else
                lastMsg = nil
                time = nil
            end

            if !GroupProfile.exists?(group_id: group.group_id)
                groupName = "unknown"
            else
                groupName = GroupProfile.find_by(group_id: group.group_id).group_name
            end
            output = { :conversation_id => group.conversation_id, :groupName => groupName, :time => time, :lastMsg => lastMsg }
            allGroups.push(output)
        end

        render json: { success: 'ok', directs: allDirects, groups: allGroups }
    end

    def create
        # check params
        if !params[:user1_email] || !params[:user2_email]
            render json: { success: 'no', msg: 'not enough info' }
            return
        end
        unless User.exists?(email: params[:user1_email])
            render json: { success: 'no', msg: 'user1 does not exist' }
            return
        end
        unless User.exists?(email: params[:user2_email])
            render json: { success: 'no', msg: 'user2 does not exist' }
            return
        end

        user1Id = User.find_by(email: params[:user1_email]).user_id
        user2Id = User.find_by(email: params[:user2_email]).user_id

        if Direct.exists?(user1_id: user1Id, user2_id: user2Id) || Direct.exists?(user1_id: user2Id, user2_id: user1Id)
            render json: { success: 'no', msg: 'conversation between them already exists' }
            return
        end

        begin
            newConvoId = SecureRandom.hex(16)
        end while Direct.exists?(conversation_id: newConvoId)

        Direct.create(user1_id: user1Id, user2_id: user2Id, conversation_id: newConvoId)

        render json: { success: 'ok', conversation_id: newConvoId, msg: 'convo created' }
    end


end
