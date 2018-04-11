class Api::V1::SessionsController < ApplicationController
  before_action :require_login, only: [:session_logout]

  def session_login
    #login_params = JSON.parse(request.raw_post)
    if user = User.valid_login?(session_params['email'], session_params['password'])
      allow_token_to_be_used_only_once_for(user)
      send_auth_token_for_valid_login_of(user)
    else
      render_unauthorized('Your Email or Password is invalid')
    end
  end

  def session_logout
    logout
    render json: {message: 'Logout successfully!'}
  end


  private

  def session_params
    params.permit(:email, :password)
  end

  def send_auth_token_for_valid_login_of(user)
    render json: user, except: [:password_digest], success: 1
  end

  def allow_token_to_be_used_only_once_for(user)
    user.regenerate_token
  end

  def logout
    current_user.invalidate_token
  end
end
