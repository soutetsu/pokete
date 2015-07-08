class BokesController < ApplicationController
  before_action :set_theme, only: [:index]
  before_action :set_boke, only: [:show]
  before_action :set_category

  def index
    @bokes = @theme.bokes.page(params[:page])
  end

  def show
  end

  def recent
    if @category
      @bokes = @category.bokes.order(created_at: :desc)
    else
      @bokes = Boke.order(created_at: :desc)
    end
    @bokes = @bokes.page(params[:page])
  end

  def popular
    if @category
      @bokes = @category.bokes.order(cached_weighted_average: :desc)
    else
      @bokes = Boke.order(cached_weighted_average: :desc)
    end
    @bokes = @bokes.page(params[:page])
  end

  def hall_of_fame
    @bokes = Boke.hall_of_fame.page(params[:page])
  end

  def show
  end

  private

    def set_category
      @category = Category.find(params[:category_id]) if params[:category_id].present?
    end

    def set_boke
      @boke = Boke.find(params[:id])
    end

    def set_theme
      @theme = Theme.find(params[:theme_id])
    end
end
