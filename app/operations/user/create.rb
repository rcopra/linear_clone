# frozen_string_literal: true

class User::Create
  include Operation

  def initialize(params)
    @params = params
  end

  def call
    user = User.new(@params)

    if user.save
      success(user)
    else
      failure(user)
    end
  end
end
