# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = UserDecorator.decorate_collection(User.all)
  end

  def create
    operation = User::Create.new(user_create_params.to_h)
    result = operation.call

    if result.success?
      render json: UserBlueprint.render(result.model), status: :created
    else
      render json: { errors: result.model.errors.full_messages }, status: :unprocessable_entity
    end
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
