class ApplicationController < ActionController::API

  def require_login
    authenticate_token || render_unauthorized('Session Has Been Expired.')
  end

  def current_user
    @current_user ||= authenticate_token
  end


  protected

  def render_unauthorized(message)
    message = {message: message }
    render json: message, status: :forbidden
  end


  private

  def authenticate_token
    user = User.find_by(token: request.headers[:token])
  end
end
