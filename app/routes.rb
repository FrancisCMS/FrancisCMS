module FrancisCMS
  module Routes
    Dir.glob('app/routes/*.rb').each do |f|
      autoload File.basename(f, '.*').capitalize.to_sym, f
    end
  end
end