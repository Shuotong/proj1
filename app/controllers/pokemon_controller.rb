class PokemonController < ApplicationController
	def capture
		@pokemon = Pokemon.find(params[:id])
		@pokemon.trainer_id = current_trainer.id
		@pokemon.save
		current_trainer.save
		redirect_to root_path
	end

	def damage
		@pokemon = Pokemon.find_by id: params[:id]
		@pokemon.health = @pokemon.health - 10
		if @pokemon.health <= 0
			@pokemon.destroy
		else
			@pokemon.save
		end
		redirect_to current_trainer
	end

	def new
		@pokemon = Pokemon.new
	end
	
	def create
		@pokemon = Pokemon.new
		@pokemon.name = params[:pokemon][:name]
		@pokemon.health = 100
		@pokemon.level = 1
		@pokemon.trainer_id = current_trainer.id
		if @pokemon.save
			redirect_to current_trainer
		else
			flash[:error] = @pokemon.errors.full_messages.to_sentence
			redirect_to new_path
		end
	end

end
