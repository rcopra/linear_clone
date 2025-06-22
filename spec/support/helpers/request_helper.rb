# frozen_string_literal: true

module RequestHelpers
  def json_headers
    { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
  end
end
