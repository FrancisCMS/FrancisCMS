body = <<-EOS
This is an example of a post, written in Markdown.

# Why Markdown?

_Glad you asked!_

Because it's "super-easy" to write and you can do **all kinds of things** like [link to Google](http://google.com/), ~~strikethrough some text~~, and avoid_intra_emphasis.

## Lists are easy, too

- Item 1
- Item 2
- Item 3
EOS

Post.create(
  title: 'A sample first post',
  body: body,
  excerpt: 'This is a sample excerpt, which is a string with no markup.',
  published_at: Time.now
)