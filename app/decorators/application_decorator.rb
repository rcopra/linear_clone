# frozen_string_literal: true

class ApplicationDecorator < SimpleDelegator
  include ActionView::Helpers
  include Rails.application.routes.url_helpers

  def self.decorate_collection(records)
    records.map { |record| new(record) }
  end

  def current_user
    Current.user
  end

  def t(*, **)
    I18n.t(*, **)
  end
end
