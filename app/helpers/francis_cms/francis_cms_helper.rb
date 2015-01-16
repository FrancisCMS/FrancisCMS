module FrancisCms::FrancisCmsHelper
  def francis_cms_admin_panel
    render 'francis_cms/shared/admin_panel'
  end

  def francis_cms_config
    FrancisCms.configuration
  end
end
