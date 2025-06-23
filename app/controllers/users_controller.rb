# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :user, only: %i[show update destroy]

  def index
    render json: {
      users: UserBlueprint.render_as_hash(User.all)
    }
  end

  def show
    render_json_response user, user.present?, status: :ok
  end

  def create
    result = User::Create.new(user_create_params.to_h).call

    render_json_response result.model, result.success?, status: :created
  end

  def update
    result = User::Update.new(user, user_update_params).call

    render_json_response result.model, result.success?, status: :ok
  end

  def destroy
    user.destroy!
    head :no_content
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def user_create_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :password
    )
  end

  def user_update_params
    params.require(:user).permit(
      :first_name, :last_name, :email
    )
  end
end
