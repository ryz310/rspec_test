class SessionsController < ApplicationController
  def create
    if false
    else
      flash.alert = 'Invalid username or password.'
    end
    redirect_to :root
  end
end
