# frozen_string_literal: true

# Used to enable a class to be called with ClassName.call(params)
module Callable
  extend ActiveSupport::Concern

  class_methods do
    def call(...)
      new(...).call
    end

    def call!(...)
      new(...).call!
    end
  end
end
