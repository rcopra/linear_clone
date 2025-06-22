# frozen_string_literal: true

class User::Update
  include Operation

  def initialize(user, update_params)
    @user = user
    @params = update_params.is_a?(ActionController::Parameters) ? update_params : update_params.deep_symbolize_keys # rubocop:disable Layout/LineLength
  end

  def call
    if @user.update(@params)
      success(@user)
    else
      failure(@user)
    end
  end
end
