class RoleVO
  attr_accessor :username, :roles
  def initialize(username=nil,roles=[])
    self.username = username
    self.roles = roles
  end
end
# PureMVC Ruby Standard Demo - Employee Admin
# Ported to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
