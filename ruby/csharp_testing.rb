User = Struct.new(:name, :type)

all_users = ["Adam", :guest],  ["Ben", :customer], ["Charlie", :admin]

all_users.each { |user| puts User.new(user[0], user[1]) }
