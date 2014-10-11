module FrancisCMS
  module Helpers
    Dir.glob('app/helpers/*.rb').each do |f|
      autoload File.basename(f, '.*').titleize.gsub(/\s+/, '').to_sym, f
    end
  end
end