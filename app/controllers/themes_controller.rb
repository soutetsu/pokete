class ThemesController < ApplicationController
  before_action :set_category
  before_action :set_theme, only: [:show]

  def index
    if @category
      @themes = @category.themes.order(created_at: :desc)
    else
      @themes = Theme.order(created_at: :desc)
    end
    @themes = @themes.page(params[:page])
  end

  def show
  end

  private

    def set_category
      @category = Category.find(params[:category_id]) if params[:category_id]
    end

    def set_theme
      @theme = Theme.find(params[:id])
    end
end
