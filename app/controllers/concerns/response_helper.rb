# frozen_string_literal: true

# helper to construct unified response
module ResponseHelper
  private

  def render_json_response(record, saved, status: :ok, blueprint: nil, **, &)
    blueprint ||= Module.const_get "#{record.class.name}Blueprint"

    return render_unprocessable_entity(record) unless saved

    yield if block_given?

    render(json: blueprint.render(record, **), status:)
  end

  def render_unprocessable_entity(failure)
    msg = case failure
          when ActiveRecord::Base
            { message: failure.errors.full_messages.join('. '), errors: failure.errors.messages }
          when StandardError
            { message: sanitize_message(failure) }
          else
            { errors: failure.errors }
          end

    render json: msg, status: :unprocessable_entity
  end

  def sanitize_message(failure)
    failure.respond_to?(:original_message) ? failure.original_message : failure.message
  end
end
