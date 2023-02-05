class ListsController < ApplicationController
  before_action :authorized
  before_action :find_user
  before_action :find_todo, only: [:destroy, :update]

  def index
    @todo = @user.list
    limit, page = (params[:per_page] || 10).to_i, (params[:page] || 0).to_i
    @todo = @todo.offset(limit * page ).limit(limit)
    @todo = @todo.reverse()
    render json: { list: @todo }
  end

  def create
    todo = @user.list.create(todo_params)
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
    # debugger
    if @todo.update(todo_params)
      render json: { list: @todo, message:"updated" }
    else
      render json: { error: @todo, message: "something went wrong" }
    end
    # render json: { list: @todo, message:"created" }
  end

  def destroy
    @todo.destroy
  end

  private

  def find_user
    @user = User.find_by(id: params[:user_id])
  end
  
  def find_todo
    @todo = @user.list.find_by(id: params[:id])
  end
  def todo_params
    params.require(:todo).permit(:id, :description, :completed)
  end
end
