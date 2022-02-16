class RecipesController < ApplicationController


  def new
    @recipe = Recipe.new
    @recipe.materials.build
    @recipe.steps.build
  end

  def create
    @recipe = Recipe.new (recipe_params)
    if @recipe.save
        redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end

  def index
    #step数別にレシピ表示
    @recipe_step_2 = Recipe.where(steps_count: "2").page(params[:page]).per(8)
    @recipe_step_3 = Recipe.where(steps_count: "3").page(params[:page]).per(8)
    @recipe_step_4 = Recipe.where(steps_count: "4").page(params[:page]).per(8)
    @recipe_step_5 = Recipe.where(steps_count: "5").page(params[:page]).per(8)
    if @tag = params[:tag_name]  # タグ検索用
     #binding.pry
      @tag_recipe = Recipe.tagged_with(params[:tag_name])   # タグに紐付く投稿
    end
  end

  def show
   @recipe = Recipe.find(params[:id])
   @tags = @recipe.tag_counts_on(:tags)
   @materials = @recipe.materials
   @steps = @recipe.steps
   @impression = @recipe.impression.new
   @impressions = Impression.where(recipe_id: @recipe.id)
  end

   def edit
    @recipe = Recipe.find(params[:id])
   end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(params[:id])
    else
      render 'edit'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end


  private

    def recipe_params
      params.require(:recipe).permit(:id,:name, :introduction, :note , :image,:user_id,:tag_list,:serving,:steps_count,:tag_name,
                               steps_attributes: [:id,:explanation,:image,:recipe_id, :_destroy],
                               materials_attributes: [:id,:name,:recipe_id,:quantity, :_destroy] )
    end
end
