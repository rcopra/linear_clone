# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = UserDecorator.decorate_collection(User.all)
  end
end
