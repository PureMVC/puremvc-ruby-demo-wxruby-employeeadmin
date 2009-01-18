class UserVO
  attr_accessor :fname, :lname, :email, :password, :department, :username
  def initialize(uname=nil, fname=nil, lname=nil, email=nil, password=nil, department=DeptList::DEPT_NONE_SELECTED)
    self.username = uname
    self.fname = fname
    self.lname = lname
    self.email = email
    self.department = department
    self.password = password
  end
 
  def is_valid?
    return self.username && self.password && self.department != DeptList::DEPT_NONE_SELECTED
  end
  
  def given_name
    "#{self.lname}, #{self.fname}"
  end
end
# PureMVC Ruby Standard Demo - Employee Admin
# Ported to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
