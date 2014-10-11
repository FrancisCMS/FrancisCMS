module FrancisCMS
  module Concerns
    Dir.glob('app/models/concerns/*.rb').each do |f|
      autoload File.basename(f, '.*').capitalize.to_sym, f
    end
  end
end