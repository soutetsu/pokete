class My::BokesController < My::ApplicationController
  before_action :set_theme, only: [:new, :create, :edit, :update]
  before_action :set_boke, only: [:edit, :update, :destroy]

  def index
    @bokes = current_user.bokes.order(updated_at: :desc).page(params[:page])
  end

  def new
    @boke = current_user.bokes.new(theme_id: @theme.id)
  end

  def create
    @boke = current_user.bokes.build(boke_params)
    @boke.theme_id = @theme.id
    respond_to do |format|
      if @boke.save
        format.html { redirect_to recent_bokes_path, notice: 'ボケを投稿しました' }
      else
        format.html { render 'new' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @boke.update(boke_params)
        format.html { redirect_to my_bokes_path, notice: 'ボケを編集しました' }
      else
        format.html { render 'edit' }
      end
    end
  end

  def destroy
    @boke.destroy
    redirect_to my_bokes_path, notice: 'ボケを削除しました'
  end

  private

    def set_theme
      @theme = Theme.find(params[:theme_id])
    end

    def set_boke
      @boke = current_user.bokes.find(params[:id])
    end

    def boke_params
      params.require(:boke).permit(:tag_list, :content)
    end
end
