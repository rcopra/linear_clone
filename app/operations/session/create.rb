# frozen_string_literal: true

class Session::Create
  include Operation

  def initialize(params)
    @params = params
  end

  def call
    user = User.find_by(email: @params[:email])

    if user&.authenticate(@params[:password])
      success(user)
    else
      failure(user)
    end
  end
end
