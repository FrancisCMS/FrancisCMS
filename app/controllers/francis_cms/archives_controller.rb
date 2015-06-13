require_dependency 'francis_cms/francis_cms_controller'

module FrancisCms
  class ArchivesController < FrancisCmsController
    def index
      resource_type

      @years = parent_class.years
    end

    def show
      resource_type
      year

      @results = parent_class.for_year(@year)
    end

    private

    def resource_type
      @resource_type ||= parent.capitalize.pluralize
    end

    def parent
      @parent ||= %w(posts links).find { |p| request.path.split('/').include? p }.singularize
    end

    def parent_class
      @parent_class ||= "FrancisCms::#{parent.classify}".constantize
    end

    def year
      @year ||= params[:year]
    end
  end
end
