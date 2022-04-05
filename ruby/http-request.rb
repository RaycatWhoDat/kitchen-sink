require 'json'
require 'net/http'

posts =
  JSON Net::HTTP.get URI 'https://jsonplaceholder.typicode.com/users/1/posts'
print posts[0]
