class My::EvaluationsController < My::ApplicationController
  before_action :set_boke
  before_action :set_evaluation, only: :destroy

  def new
    @evaluation = current_user.evaluations.new(boke_id: @boke_id)
  end

  def create
    @evaluation = current_user.evaluations.new(evaluation_params)
    @evaluation.boke_id = @boke.id
    respond_to do |format|
      if @evaluation.save
        format.html { redirect_to theme_boke_path(@boke, theme_id: @boke.theme_id), notice: 'このボケを評価しました' }
      else
        format.html { render 'new' }
      end
    end
  end

  def destroy
    @evaluation.destroy
    redirect_to theme_boke_path(@boke, theme_id: @boke.theme_id), notice: 'このボケへの評価を取り下げました'
  end

  private

    def set_boke
      @boke = Boke.find(params[:boke_id])
    end

    def set_evaluation
      @evaluation = current_user.evaluations.find(params[:id])
    end

    def evaluation_params
      params.require(:evaluation).permit(:point, :comment)
    end
end
