module FrancisCMS
  module Models
    Dir.glob('app/models/*.rb').each do |f|
      autoload File.basename(f, '.*').capitalize.to_sym, f
    end
  end
end