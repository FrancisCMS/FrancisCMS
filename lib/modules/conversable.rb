require 'colored'

module Conversable
  # rubocop:disable Rails/Output
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
  # rubocop:enable Rails/Output

  def confirm?(msg)
    case ask?(msg)
    when 'Y', 'y', 'yes', 'YES'
      true
    else
      false
    end
  end
end
