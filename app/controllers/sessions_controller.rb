class SessionsController < ApplicationController
  def show
    render json: blueprint_class.render(current_user, view: :session), status: :ok
  end

  def create
    result = Session::Create.call(session_params)

    if result.success?
      session[:user_id] = result.model.id
      render json: UserBlueprint.render(result.model, view: :session), status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
