class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(rules_path, notice: 'Du bist jetzt eingeloggt!')
    else
      flash.now[:alert] = 'Einloggen fehlgeschlagen!'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(rules_path, notice: 'Du bist jetzt ausgeloggt!')
  end
end
