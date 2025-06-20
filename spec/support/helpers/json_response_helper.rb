# frozen_string_literal: true

module JsonResponseHelper
  def parsed_response
    JSON.parse(response.body) unless response.body.empty?
  end
end
