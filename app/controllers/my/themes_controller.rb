class My::ThemesController < My::ApplicationController
  before_action :set_theme, only: [:edit, :update, :destroy]

  def index
    @themes = current_user.themes.page(params[:page])
  end

  def new
    @theme = current_user.themes.new
  end

  def create
    @theme = current_user.themes.build(theme_params)
    respond_to do |format|
      if @theme.save
        format.html { redirect_to my_themes_path, notice: '新しいお題を投稿しました' }
      else
        format.html { render 'new' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @theme.update(theme_params)
        format.html { redirect_to my_themes_path, notice: 'お題を編集しました' }
      else
        format.html { render 'edit' }
      end
    end
  end

  def destroy
    @theme.destroy
    redirect_to my_themes_path, notice: 'お題を削除しました'
  end

  private

    def set_theme
      @theme = current_user.themes.find(params[:id])
    end

    def theme_params
      params.require(:theme).permit(:category_id, :uri)
    end
end
