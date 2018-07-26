class EpicenterController < ApplicationController

	before_action :authenticate_user!, except: [:feed]

  def feed
      @tweet = Tweet.new
      @following_tweets =[]

      Tweet.all.each do |tweet|
        if current_user.following.include?(tweet.user_id) || current_user.id == tweet.user_id
          @following_tweets.push(tweet)
        end
      end 
  


  	# if user_signed_in?
	  # 	@following_tweets =[]

	  # 	Tweet.all.each do |tweet|
	  # 		if current_user.following.include?(tweet.user_id) || current_user.id == tweet.user_id
	  # 			@following_tweets.push(tweet)
	  # 		end
	  # 	end	
	  # else
	  # 	redirect_to tweets_path
	  # end	
	end

  def show_user
    @tweet = Tweet.new
  	@user = User.find(params[:id])
  end

  def now_following
  	current_user.following.push(params[:id].to_i)
  	current_user.save

  	redirect_to show_user_path(id: params[:id])
  end

  def unfollow
  	current_user.following.delete(params[:id].to_i)
  	current_user.save

  	redirect_to show_user_path(id: params[:id])
  end


  def tag_tweets
    @tag = Tag.find(params[:id])
  end  
end
