module Helpers
  def log_in
    allow_any_instance_of(::FrancisCms::FrancisCmsController)
      .to receive(:__logged_in__)
      .and_return(true)
  end
end
