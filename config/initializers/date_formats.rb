Time::DATE_FORMATS[:display] = lambda { |time| time.strftime "%B %e<sup>#{time.day.ordinal}</sup>, %Y at %l:%M %P %Z" }
Time::DATE_FORMATS[:rfc822]  = lambda { |time| time.strftime '%a, %d %b %Y %H:%M:%S %Z' }
