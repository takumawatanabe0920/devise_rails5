class MicropostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]
  def index
    @q = current_user.microposts.ransack(params[:q])
    @microposts = @q.result(distinct: true)
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @microposts = current_user.microposts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def edit
    @micropost = Micropost.find(params[:id])
  end

  def update
    @micropost = Micropost.find(params[:id])
    if @micropost.update(micropost_params)
      flash[:success] = "メッセージ は正常に更新されました"
      redirect_to root_url
    else
      flash.now[:danger] = 'メッセージ は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :name)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost
      redirect_to root_url
    end
  end
end
