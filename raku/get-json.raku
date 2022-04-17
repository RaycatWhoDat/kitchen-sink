use WWW;

my @posts = jget("https://jsonplaceholder.typicode.com/users/1/posts");
.<body>.say for @posts;
