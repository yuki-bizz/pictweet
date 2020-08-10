
class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show]
  # before_action :move_to_index, except: [:index, :show, :search]

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(tweet_params)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end

  def edit
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  def search
    @tweets = Tweet.search(params[:keyword])
  end

  private
  def tweet_params
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end

# class TweetsController < ApplicationController

#   # before_action :move_to_index, except: :index
#   before_action :set_tweet, only: [:edit, :show, :destroy, :update]  #追記

#   def index
#     @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC")
#   end

#   def new
#     return
#   end

#   def create
#    #Tweet.create(image: tweets_params[:image], text: tweets_params[:text], user_id: current_user.id)
#     Tweet.create(tweets_params)
#   end

#   def destroy
#    #@tweet = Tweet.find(params[:id])
#     if @tweet.user_id == current_user.id
#       @tweet.destroy
#     end
#   end

#   def edit
#    @tweet = Tweet.find(params[:id])
#   end

#   def update
#    #@tweet = Tweet.find(params[:id])
#     if @tweet.user_id == current_user.id
#       @tweet.update(tweet_params)
#     end
#   end

#   def show
#    #@tweet = Tweet.find(params[:id])
#     @comments = @tweet.comments.includes(:user)
#   end

#   private
#   def tweets_params
#     params.permit(:image, :text).merge(user_id: current_user.id)  #merge以降追記
#   end

#   def move_to_index
#     redirect_to action: :index unless user_signed_in?
#   end

#   def set_tweet  #追記
#     @tweet = Tweet.find(params[:id]) #追記
#   end
# end


# def index
#   @user = current_user
#   messages = @user.messages
#   end