# ----- Links ---------- #

Link.create(
  url: 'http://google.com/',
  title: 'Google'
)

Link.create(
  url: 'http://sixtwothree.org/',
  title: 'sixtwothree.org'
)

Link.create(
  url: 'http://cnn.com/',
  title: 'CNN',
  body: 'They call themselves a "news organization."'
)

# ----- Posts ---------- #

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
  excerpt: 'This is a sample excerpt, which is a string with no markup.'
)