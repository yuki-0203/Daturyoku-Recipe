class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @recipes = Recipe.where(user_id: @user.id)
     #ユーザーのお気に入りにしているレシピ全てを表示
    favorites = Favorite.where(user_id: @user.id).pluck(:recipe_id)
    @favorite_recipes = Recipe.find(favorites)
    #レシピのお気に入り数をカウント
    recipe = Recipe.find(params[:id])
    @recipe_favorites_count = Favorite.where(recipe_id: recipe).count
    #ユーザーの投稿脱レポの全てを表示
    @impressions = Impression.where(user_id: @user.id)
  end

  def profile
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update!(user_params)
      redirect_to user_path(@user), notice: 'You have updated user successfully.'
    else
      render 'profile'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :phone_number, :is_gender, :nickname, :introduction, :image, :password)
  end
end
