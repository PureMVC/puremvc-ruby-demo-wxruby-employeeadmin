class AppFrame < Wx::Frame
  attr_accessor :user_list, :role_panel, :user_form
  def initialize
    super(nil, -1, "PureMVC_Ruby - Employee Admin Demo", Wx::Point.new(-1,-1), Wx::Size.new(665,550))
    @user_list = UserList.new(self)
    @role_panel = RolePanel.new(self)
    @user_form = UserForm.new(self)
  end
end
# PureMVC Ruby Standard Demo - Employee Admin
# Ported to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
