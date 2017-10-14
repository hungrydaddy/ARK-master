class GroupController < ApplicationController
    def create
        if !params[:email] || !params[:group_name]
            render json: { success: 'no', msg: 'not enough info' }
            return
        end
        unless User.exists?(email: params[:email])
            render json: { success: 'no', msg: 'user does not exist' }
            return
        end

        userId = User.find_by(email: params[:email]).user_id

        begin
            newGroupId = SecureRandom.hex(16)
        end while Group.exists?(group_id: newGroupId)

        begin
            newConvoId = SecureRandom.hex(16)
        end while Message.exists?(conversation_id: newConvoId)

        newGroup = Group.create(group_id: newGroupId, user_id: userId, conversation_id: newConvoId)
        Usergroup.create(user_id: userId, group_id: newGroupId)
        GroupProfile.create(group_id: newGroupId, group_name: params[:group_name])

        render json: { success: 'ok', group_id: newGroupId }
    end



    def add
        if !params[:group_id] || !params[:email]
            render json: { success: 'no', msg: 'not enough info' }
            return
        end
        unless User.exists?(email: params[:email])
            render json: { success: 'no', msg: 'user does not exist' }
            return
        end
        userId = User.find_by(email: params[:email]).user_id

        if !Group.exists?(group_id: params[:group_id])
            render json: { success: 'no', msg: 'group does not exist' }
            return
        end

        if Usergroup.exists?(group_id: params[:group_id], user_id: userId)
            render json: { success: 'no', msg: 'already in this group' }
            return
        end

        convoId = Group.find_by(group_id: params[:group_id]).conversation_id

        Usergroup.create(user_id: userId, group_id: params[:group_id])
        Group.create(user_id: userId, group_id: params[:group_id], conversation_id: convoId)

        render json: { success: 'ok', msg: 'done' }
    end




    def delete
        if !params[:group_id] || !params[:email]
            render json: { success: 'no', msg: 'not enough info' }
            return
        end
        unless User.exists?(email: params[:email])
            render json: { success: 'no', msg: 'user does not exist' }
            return
        end
        userId = User.find_by(email: params[:email]).user_id

        if !Group.exists?(group_id: params[:group_id])
            render json: { success: 'no', msg: 'group does not exist' }
            return
        end

        if !Usergroup.exists?(group_id: params[:group_id], user_id: userId)
            render json: { success: 'no', msg: 'not in group' }
            return
        end

        Usergroup.find_by(user_id: userId, group_id: params[:group_id]).destroy
        Group.find_by(user_id: userId, group_id: params[:group_id]).destroy
        GroupProfile.find_by(group_id: params[:group_id]).destroy

        render json: { success: 'ok', msg: 'done' }
    end






    def show
        if !params[:email]
            render json: { success: 'no', msg: 'not enough info' }
            return
        end
        unless User.exists?(email: params[:email])
            render json: { success: 'no', msg: 'user does not exist' }
            return
        end
        userId = User.find_by(email: params[:email]).user_id

        allGroups = Array.new

        Group.where(user_id: userId).find_each do |group|
            allGroups.push(group.group_id)
        end

        render json: { success: 'ok', groups: allGroups }

    end



    def members
        if !params[:email]
            render json: { success: 'no', msg: 'not enough info' }
            return
        end
        unless User.exists?(email: params[:email])
            render json: { success: 'no', msg: 'user does not exist' }
            return
        end
        userId = User.find_by(email: params[:email]).user_id

        allGroups = Array.new

        Group.where(user_id: userId).find_each do |group|
            allGroups.push(group.group_id)
        end

        output = Array.new

        for groupId in allGroups
            groupMmebers = Array.new
            Group.where(group_id: groupId).find_each do |groupuser|
                groupMmebers.push(User.find_by(user_id: groupuser.user_id).email)
            end
            output.push({ :group_id => groupId, :members => groupMmebers })
        end

        render json: { success: 'ok', groups: output }

    end



    def locations
        if !params[:group_id]
            render json: { success: 'no', msg: 'not enough info' }
            return
        end
        unless Group.exists?(group_id: params[:group_id])
            render json: { success: 'no', msg: 'group does not exist' }
            return
        end

        allUsersId = Array.new

        Usergroup.where(group_id: params[:group_id]).find_each do |usergroup|
            allUsersId.push(usergroup.user_id)
        end

        allUserLocationAndEmail = Array.new

        for userId in allUsersId
            email = User.find_by(user_id: userId).email
            location = Location.find_by(user_id: userId)
            obj = { :email => email, :location => location }
            allUserLocationAndEmail.push(obj)
        end

        render json: { success: 'ok', groups: allUserLocationAndEmail }
    end



    def search
        if !params[:group_name]
            render json: { success: 'no', msg: 'not enough info' }
            return
        end
        allGroupsId = Array.new
        GroupProfile.where(group_name: params[:group_name]).find_each do |groupprofile|
            allGroupsId.push(groupprofile.group_id)
        end

        render json: { success: 'ok', groups: allGroupsId }
    end


end
