class GamesController < ApplicationController
   before_action :find_game, only: [:show, :edit, :update, :destroy]

    def index
        if params[:genre].blank?
            @games = Game.all.order("created_at DESC")
        else
            @genre_id = Genre.find_by(name: params[:genre]).id
            @games = Game.where(:genre_id => @genre_id).order("created_at DESC")
        end

    end 

    def show
        @games = Game.find(params[:id])
        @reviews = @games.reviews
    end

    def new
        @game = current_user.games.build
        @genres = Genre.all.map{ |g| [g.name, g.id] }
    end

    def create 
        @game = current_user.games.build(game_params)
        @game.genre_id = params[:genre_id]
        # @user = current_user
        # @user.avatar.attach(params[:avatar])
        if @game.save 
            redirect_to root_path
        else
            render 'new'
        end
    end

    def edit
        @genres = Genre.all.map{ |g| [g.name, g.id] }
    end
    
    def update
        @game.genre_id = params[:genre_id]
        if @game.update(game_params)
            redirect_to game_path(@game)
        else
            render 'edit'
        end
    end

    def destroy
        @game.destroy
        redirect_to root_path(@game)
    end


    private 
    def game_params
        params.require(:game).permit(:title, :description, :developer, :avatar)
    end

    def find_game
        @game = Game.find(params[:id])
    end


end
