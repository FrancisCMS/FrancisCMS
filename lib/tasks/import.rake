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

namespace :import do
  include Conversable

  desc 'Import links from a JSON file'
  task :links do
    filepath = ask?('What is the full path to your links JSON file? (e.g. `/Users/you/Desktop/links.json`)')

    if File.exists? filepath
      links = JSON.load(File.open(filepath, 'r'))

      links.each do |link|
        Link.new(
          url: link['url'],
          title: link['title'],
          body: link['comment'],
          tag_list: link['tags'],
          published_at: link['add_date']
        ).save!

        sleep(1)
      end

      notify '✓ Links successfully imported!'
    else
      alert "! Couldn't find `#{filepath}`. Skipping links import..."
    end
  end

  desc 'Import posts from a folder of Jekyll-style Markdown files'
  task :posts do
    folderpath = ask?('What is the full path to your folder of Markdown files? (e.g. `/Users/you/Desktop/posts`)')

    if Dir.exists? folderpath
      File.join(folderpath, '*.md').each do |filepath|
        yaml = YAML.load_file(filepath)

        post = Post.new({
          body: IO.read(filepath).split("\n---\n\n")[1],
          published_at: yaml['date'],
          slug: /\d{4}-\d{2}-\d{2}-(.+?).md/.match(filepath)[1],
          title: yaml['title']
        })

        post.excerpt = yaml['excerpt'] unless yaml['excerpt'].nil?
        post.tag_list = yaml['tags'].gsub(' ', ', ') unless yaml['tags'].nil?

        unless yaml['copies'].nil?
          yaml['copies'].each do |copy|
            post.syndications.new({ name: copy['title'], url: copy['url'] })
          end
        end

        post.save!

        sleep(1)
      end

      notify '✓ Posts successfully imported!'
    else
      alert "! Couldn't find `#{folderpath}`. Skipping posts import..."
    end
  end
end