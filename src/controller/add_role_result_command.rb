class AddRoleResultCommand < SimpleCommand
  ROLE_EXISTS_ERROR = "Role already exists for this user."
  
  def execute(note)
    self.facade.send_notification(NotificationName::SHOW_DIALOG, ROLE_EXISTS_ERROR) unless note.body
  end
end
# PureMVC Ruby Standard Demo - Employee Admin
# Ported to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
