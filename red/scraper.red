Red []

raw-html: read https://en.wikipedia.org/wiki/Chicago
link: [thru "href=^"" keep to dbl-quote]
probe new-line/all parse raw-html [collect some link] on