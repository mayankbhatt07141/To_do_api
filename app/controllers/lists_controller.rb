class ListsController < ApplicationController
  before_action :authorized
  def index
    user = User.find_by(id: params[:user_id])

    @todo = user.list
    limit, page = (params[:per_page] || 10).to_i, (params[:page] || 0).to_i
    @todo = @todo.offset(limit * page ).limit(limit)
    @todo = @todo.reverse()
    render json: { list: @todo }
  end

  def create
    user = User.find_by(id: params[:user_id])
    @todo = user.list.create(todo_params)

    render json: { list: @todo, message:"created" }
  end

  def search

  end

  def update
    # @todo = List.find_by(id: params[:id])
    
    # if @todo.present?
    #   puts "inside"
    #   if @todo.update(todo_params)
    #     puts "data"
    #     render json: { list: @todo }
    #   else
    #     render json: { error: "something went wrong" }, status: 500
    #   end
    # else
    #   render json: { msg: "no content found" }, status: 204
    # end
  end

  def destroy
    # @todo = List.find(params[:id])
    # @todo.destroy
  end

  private

  def todo_params
    puts params[:todo]
    params.require(:todo).permit(:id, :description, :completed)
  end
end
