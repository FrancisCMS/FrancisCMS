Time::DATE_FORMATS.merge!(
  display: lambda { |time| time.strftime "%B %e<sup>#{time.day.ordinal}</sup>, %Y at %l:%M %P %Z" },
  rfc822:  lambda { |time| time.strftime "%a, %d %b %Y %H:%M:%S %Z" }
)