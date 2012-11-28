module V1
  class UsersApi < Raisin::API
    #single_resource

    get '/', as: "index" do
    #enable_auth
      expose(:users) {
        User.where(:id => current_user.id)
      }
      #response do
      #  render json: users
      #end
    end

    get '/all', as: "showall" do
      expose(:all_users){
        if current_user.admin?
          User.all
        else
          User.where(:id => current_user.id)
        end
      }
     # response do
      #  render json: all_users
      #end
    end

    delete '/deleteUser', as: "deleteuser" do
      expose(:user_del){User.where(:id => params[:id]).first}
      response do
        result = nil
          if user_del.nil?
            result ="warning : can not find this user"
         
        elsif !user_del.destroy
          result ="failed : can not delete this user"
        else
          result ="succed : delete user succed"
        end
        render json: result
      end     
    end

     post '/updateUsers', as: "updateusers" do
       expose(:updatedusers)  {Array.new()}
  
      response do
         users = params[:users]
         users.each do |user|
           if user[:id]
             current = User.find(user[:id])
             if !current.nil?
             current.update_attribute(:sc,user[:soldeConge]) if !user[:soldeConge].nil?
             current.update_attribute(:sr,user[:soldeRecup]) if !user[:soldeRecup].nil?
             current.update_attribute(:admin,user[:admin]) if !user[:admin].nil?
             updatedusers << current
             end
           end
         end
      #render json: updatedusers
       end
     end
  end
end