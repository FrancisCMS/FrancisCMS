module Publishable
  extend ActiveSupport::Concern

  included do
    attr_accessor :is_draft

    before_save :set_published_at
  end

  private

  def set_published_at
    if self.is_draft.to_b
      self.published_at = nil
    else
      self.published_at ||= Time.now
    end
  end
end