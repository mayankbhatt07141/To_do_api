class ListsController < ApplicationController

  def index
    @todo = List.all
    # debugger
    limit, page = (params[:per_page] || 10).to_i, (params[:page] || 1).to_i
    @todo = @todo.offset(limit * page ).limit(limit)
    render json: { list: @todo }
  end

  def create
    @todo = List.create(todo_params)
    render json: { list: @todo }
  end

  def search

  end

  def update
    @todo = List.find_by(id: params[:id])
    if @todo.present?
      if @todo.update(todo_params)
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
  end

  private

  def todo_params
    params.require(:todo).permit(:id, :description, :completed)
  end
end
