class Admin::FavoriteBreedsController < ApplicationController

	def index
		@breed = FavoriteBreed.new
		@breeds = FavoriteBreed.all
	end
	def create
		@breed = FavoriteBreed.new(breed_params)
		if @breed.save
			redirect_to admin_favorite_breeds_path
		else
			render :index
		end
	end

	def edit
		@breed = FavoriteBreed.find(params[:id])
	end

	def update
		@breed = FavoriteBreed.find(params[:id])
		if @breed.update(breed_params)
			redirect_to admin_favorite_breeds_path
		else
			render :edit
		end
	end

	private
		def breed_params
			params.require(:favorite_breed).permit(:cat_breed)
		end
end
