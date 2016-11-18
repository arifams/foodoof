class RecipesController < ApplicationController
	before_action :find_recipe, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]
	before_action :recipe_owner, only: [:edit, :update, :destroy]

	def index
		@recipe = Recipe.all.order("created_at DESC")
	end

	def show
	end

	def new
		@recipe = current_user.recipes.build
	end

	def create
		@recipe = Recipe.new(recipe_params)
		@recipe.user_id = current_user.id

		puts @recipe.inspect

		if @recipe.save
			redirect_to @recipe, notice: "Succesfully created new recipe, chef"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @recipe.update(recipe_params)
			redirect_to @recipe
		else
			render 'edit'
		end
	end

	def destroy
		@recipe.destroy
		redirect_to root_path, notice: "Succesfully deleted your recipe, chef"
	end
		
	private

	def recipe_params
		params.require(:recipe).permit(:title, 
			:description, 
			:image, 
			ingredients_attributes: [:id, :name, :_destroy], 
			directions_attributes: [:id, :step, :_destroy]).merge(user_id: current_user.id)
	end

	def find_recipe
		@recipe = Recipe.find(params[:id])
	end

	def recipe_owner
     unless @recipe.user_id == current_user.id
      flash[:notice] = 'Access denied as you are not owner of this Recipe'
      redirect_to root_path
     end
    end

end