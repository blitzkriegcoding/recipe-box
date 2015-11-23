class RecipesController < ApplicationController
	before_action :find_recipe, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@recipe = Recipe.all.order("created_at DESC")
		
	end

	def show
		render 'show'
	end	


	def new
		#@recipe = Recipe.new
		@recipe = current_user.recipes.build
	end

	def create

		#@recipe = Recipe.new(recipe_params)
		@recipe = current_user.recipes.build(recipe_params)
		if @recipe.save
			redirect_to @recipe, notice: "Se ha creado una nueva receta exitosamente"
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
		redirect_to root_path, notice: "Se ha borrado la receta exitosamente"
	end

	private

	def recipe_params
		params.require(:recipe).permit(:title, :description, :image, ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy])
	end

	def find_recipe
		@recipe = Recipe.find(params[:id])
		
	end



end
