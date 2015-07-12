require_dependency 'francis_cms/francis_cms_controller'

module FrancisCms
  class ArchivesController < FrancisCmsController
    def index
      @years = parent_class.years
    end

    def show
      @year = params[:year]
      @results = parent_class.for_year(@year)
    end

    private

    def parent_class
      @parent_class ||= "FrancisCms::#{resource_type.classify}".constantize
    end
  end
end
