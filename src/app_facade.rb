class AppFacade < Facade

  def initialize_controller
    super
    self.register_command(NotificationName::STARTUP, StartupCommand)
    self.register_command(NotificationName::DELETE_USER, DeleteUserCommand)
    self.register_command(NotificationName::ADD_ROLE_RESULT, AddRoleResultCommand)
  end
  
end

class NotificationName
  STARTUP	    	= "startup"
  NEW_USER          = "newUser"
  DELETE_USER       = "deleteUser"
  CANCEL_SELECTED   = "cancelSelected"
  
  USER_SELECTED     = "userSelected"
  USER_ADDED        = "userAdded"
  USER_UPDATED      = "userUpdated"
  USER_DELETED      = "userDeleted"
  
  ADD_ROLE          = "addRole"
  ADD_ROLE_RESULT   = "addRoleResult"
  
  SHOW_DIALOG       =  "showDialog"
end

# PureMVC Ruby Standard Demo - Employee Admin
# Ported to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License

