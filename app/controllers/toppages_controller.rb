class ToppagesController < ApplicationController
  def index
    if user_signed_in?
      @micropost = current_user.microposts.build  # form_for 用
      @q = current_user.microposts.ransack(params[:q])
      @microposts = @q.result(distinct: true)
    end
  end
end
