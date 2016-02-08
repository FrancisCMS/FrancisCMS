require 'colored'

module Conversable
  def alert(msg)
    puts msg.red
  end

  def notify(msg)
    puts msg.green
  end

  def ask?(msg)
    puts msg.yellow
    STDIN.gets.chomp!
  end

  def confirm?(msg)
    case ask?(msg)
    when 'Y', 'y', 'yes', 'YES'
      true
    else
      false
    end
  end
end
