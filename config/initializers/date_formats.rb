Time::DATE_FORMATS.merge!(
  :display => lambda {|time| time.strftime "%B %e<sup>#{time.day.ordinal}</sup>, %Y at %l:%M %P %Z"}
)