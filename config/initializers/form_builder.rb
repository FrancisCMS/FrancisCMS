class FrancisCmsFormBuilder < ActionView::Helpers::FormBuilder
  def text_area(method, options = {})
    super(method, add_aria_options(@object, method, options))
  end

  def text_field(method, options = {})
    super(method, add_aria_options(@object, method, options))
  end

  def url_field(method, options = {})
    super(method, add_aria_options(@object, method, options))
  end

  private

  def add_aria_options(object, method, options)
    return options unless object.errors.include?(method)

    { 'aria-describedby': %(#{object.class.name.demodulize.downcase}_#{method}_errors) }.merge!(options)
  end
end
