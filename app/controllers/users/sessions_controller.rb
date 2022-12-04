# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  respond_to :json 

  private

  def respond_with(resource, options = {})
    render json: {
      message: "User signed in successfully",
      token: request.env["warden-jwt_auth.token"],
      data: current_user
    }, status: :ok
  end

  def respond_to_on_destroy
    token = request.headers["Authorization"]
    jwt_payload = JWT.decode(token.split(" ")[1], ENV["JWT_SECRET_KEY"]).first
    current_user = User.find(jwt_payload["sub"])

    if current_user 
      render json: {
        message: "Signed out successfully"
      }, status: :ok
    else
      render json: {
        message: "User has no active session"
      }, status: :unauthorized
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
