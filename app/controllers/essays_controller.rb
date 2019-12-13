# frozen_string_literal: true

class EssaysController < ApplicationController
  def new
    @essay = Essay.new
  end

  def create
    @essay = Essay.new(essay_params)
    if @essay.save
      redirect_to essays_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
  end

  def show
    @essay = Essay.find(params[:id])
  end

  def index
    @essays = Essay.all
  end

  def destroy
  end

  private

  def essay_params
    params.require(:essay).permit(:title, :body)
  end
end
