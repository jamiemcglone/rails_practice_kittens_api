class KittensController < ApplicationController

    def index
        @kittens = Kitten.all 

        respond_to do |f|
            f.json { render :json => @kittens }
        end
    end

    def show
        @kitten = Kitten.find(params[:id])
        respond_to do |f|
            f.json { render :json => @kitten }
        end
    end

    def new 
        @kitten = Kitten.new
    end

    def destroy
        @kitten = Kitten.find(params[:id])
        @kitten.destroy!
        redirect_to root_url
    end


    def create
        @kitten = Kitten.new(allowed_post_params)
        puts(@kitten)
        if @kitten.save
            flash[:notice] = "Kitten successfully saved!"
            redirect_to @kitten
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @kitten = Kitten.find(params[:id])
    end

    def update
        @kitten = Kitten.find(params[:id])
        if @kitten.update(allowed_post_params)
            flash[:success] = "Successfully updated the kitten"
            redirect_to @kitten
        else
            flash.now[:error] = "Error"
            render :edit, status: :unprocessable_entity
        end
    end

    private 

    def allowed_post_params
        params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end
    
end