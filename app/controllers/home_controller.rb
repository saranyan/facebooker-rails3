class HomeController < ApplicationController
   before_filter :ensure_authenticated

   def index
     @name,@friends_and_their_interests = "",{}
     
     client = current_facebook_client
     unless client.blank?
       user = Mogli::User.find("me", client)
       @name = user.name
       
       friends = Mogli::User.find("me/friends", client)
       friends.each do |f|
         @friends_and_their_interests[f.id] = {:name => f.name, :interests => f.interests.collect {|i| i.name }.join(",") }
       end
     end
   end
end