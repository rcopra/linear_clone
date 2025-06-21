# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = UserDecorator.decorate_collection(User.all)
  end

  def create # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    result = User::Create.new(user_create_params.to_h).call

    respond_to do |format|
      if result.success?
        format.json { render json: UserBlueprint.render(result.model), status: :created }
        format.html { redirect_to users_path, notice: 'User created' } # rubocop:disable Rails/I18nLocaleTexts
      else
        format.json do
          render json: { errors: result.model.errors.full_messages }, status: :unprocessable_entity
        end
        format.html do
          @user = result.model
          render :new, status: :unprocessable_entity
        end
      end
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
