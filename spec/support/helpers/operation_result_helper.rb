# frozen_string_literal: true

module OperationResultHelper
  def success_operation(model = nil)
    Operation::Result.new(true, model)
  end

  def failure_operation(model = nil)
    Operation::Result.new(false, model)
  end
end
