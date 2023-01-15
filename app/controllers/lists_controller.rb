class ListsController < ApplicationController

  def index
    @todo = List.all
    limit, page = (params[:per_page] || 10).to_i, (params[:page] || 0).to_i
    @todo = @todo.offset(limit * page ).limit(limit)
    @todo = @todo.reverse()
    render json: { list: @todo }
  end

  def create
    puts params
    @todo = List.create(todo_params)
    
    render json: { list: @todo }
  end

  def search

  end

  def update
    @todo = List.find_by(id: params[:id])
    
    if @todo.present?
      puts "inside"
      if @todo.update(todo_params)
        puts "data"
        render json: { list: @todo }
      else
        render json: { error: "something went wrong" }, status: 500
      end
    else
      render json: { msg: "no content found" }, status: 204
    end
  end

  def destroy
    @todo = List.find(params[:id])
    @todo.destroy
  end

  private

  def todo_params
    puts params[:todo]
    params.require(:todo).permit(:id, :description, :completed)
  end
end
