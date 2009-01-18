class UserProxy < Proxy
  NAME = "UserProxy"
  def initialize
    super(NAME, [])
    self.add_item(UserVO.new('lstooge','Larry', 'Stooge', "larry@stooges.com", 'ijk456', DeptList::DEPT_ACCT))
    self.add_item(UserVO.new('cstooge','Curly', 'Stooge', "curly@stooges.com", 'xyz987',DeptList::DEPT_SALES))
    self.add_item(UserVO.new('mstooge','Moe', 'Stooge', "moe@stooges.com", 'abc123', DeptList::DEPT_PLANT))
  end
  
  def get_users
    return self.data
  end
  
  def add_item(item)
    self.data << item
  end
  
  def update_item(user)
    self.data.each_with_index do |u, index|
      if u.username == user.username
        self.data[index] = user
      end
    end
  end
  
  def delete_item(user)
    get_users.delete_if{|x| x.username == user.username}
  end
  
end
# PureMVC Ruby Standard Demo - Employee Admin
# Ported to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
