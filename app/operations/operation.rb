# frozen_string_literal: true

# Represents a callable business operation and enables a unified API with
# Operation.call(..).success?
module Operation
  extend ActiveSupport::Concern

  included { include Callable }

  Result = Data.define(:success?, :model) do
    def failure?
      !success?
    end
  end

  def failure(model = nil)
    Result.new(false, model)
  end

  def success(model = nil)
    Result.new(true, model)
  end

  def resolve_result_from_model(model)
    if model.errors.messages.empty? && model.valid?
      success(model)
    else
      failure(model)
    end
  end
end
