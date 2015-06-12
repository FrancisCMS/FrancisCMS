class FrancisCms::Dragonfly::Processors::Jpg
  def call(content, quality = 72)
    content.process! :convert, "-interlace Plane -quality #{quality} -strip -unsharp 1", format: 'jpg'
  end
end
