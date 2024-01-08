class FriendsController < ApplicationController
  # before we do anything we need to take an action
  before_action :set_friend, only: %i[ show edit update destroy ]
  # step 5, associations, we need to authenticate the user, will send them to login every time
  before_action :authenticate_user!, except: [:index, :show]
  # step 7 associations, %i creates an array of option hashes
  before_action :correct_user, only: %i[ edit update destroy ]

  # GET /friends or /friends.json
  def index
    @friends = Friend.all
  end

  # GET /friends/1 or /friends/1.json
  def show
  end

  # GET /friends/new
  def new
    #original: @friend = Friend.new
    # step 8 associations will create friends to only their list
    @friend = current_user.friends.build
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends or /friends.json
  def create
    #original @friend = Friend.new(friend_params)
    # step 9 associattions will create friends to only their list
    @friend = current_user.friends.build(friend_params)

    respond_to do |format|
      if @friend.save
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully created." }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1 or /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully updated." }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1 or /friends/1.json
  def destroy
    @friend.destroy!

    respond_to do |format|
      format.html { redirect_to friends_url, notice: "Friend was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # step 6 with associations
  def correct_user
    # correct user is user has_many friends with that id
    @friend = current_user.friends.find_by(id: params[:id])
    #if not then we are going to redirect, nil will return if this is the wrong users. 
    redirect_to friends_path, notice: "Not Authorized to Edit this Friend" if @friend.nil?
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    # Step 4 Associations, add user_id to list below on params!
    def friend_params
      params.require(:friend).permit(:first_name, :last_name, :email, :phone, :twitter, :user_id)
    end
end
