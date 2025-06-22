# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    users = User.all

    render json: UserBlueprint.render_as_hash(users)
  end

  def create
    operation = User::Create.new(user_create_params.to_h)
    result = operation.call

    render_json_response result.model, result.success?, status: :created
  end

  private

  def user_create_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password
    )
  end
end
