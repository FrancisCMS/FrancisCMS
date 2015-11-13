module FrancisCms::Concerns::Models::Publishable
  extend ActiveSupport::Concern

  included do
    attr_accessor :is_draft

    before_save :set_published_at

    scope :exclude_drafts, lambda { where('published_at IS NOT NULL') }
    scope :recently_published, lambda { exclude_drafts.order('published_at DESC').limit(5) }
  end

  module ClassMethods
    def entries_for_page(options = {})
      opts = { include_drafts: false, page: nil }.merge(options)

      opts[:page] = opts[:page].to_i > 0 ? opts[:page] : nil

      if opts[:include_drafts]
        page(opts[:page]).order('created_at DESC')
      else
        exclude_drafts.page(opts[:page]).order('published_at DESC')
      end
    end

    def for_year(year)
      exclude_drafts.where('extract(year from published_at)::integer = ?', year).order('published_at ASC')
    end

    def years
      exclude_drafts.select('extract(year from published_at)::integer as year').distinct.map(&:year).sort
    end
  end

  def newer
    self.class.exclude_drafts.where('id > ?', id).first
  end

  def older
    self.class.exclude_drafts.where('id < ?', id).last
  end

  private

  def set_published_at
    if self.is_draft == '1'
      self.published_at = nil
    else
      self.published_at ||= Time.now
    end
  end
end
