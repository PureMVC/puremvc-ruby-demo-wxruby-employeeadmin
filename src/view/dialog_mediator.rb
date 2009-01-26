class DialogMediator < Mediator
  NAME = 'DialogMediator'
  ROLE_DELETE_CONFIRM_MSG = "Are you sure you want to delete role %s from %s."
  
  def initialize(view)
    super(NAME, view)
  end
  
  def list_notification_interests
    [NotificationName::SHOW_ALERT_DIALOG, NotificationName::SHOW_DELETE_ROLE_COFIRMATION]
  end
  
  def handle_notification(note)
    role, user = note.body
    if note.name == NotificationName::SHOW_ALERT_DIALOG
      Wx::MessageDialog.new(self.view, note.body, 'Alert', Wx::OK|Wx::ICON_EXCLAMATION).show_modal
    end
    if note.name == NotificationName::SHOW_DELETE_ROLE_COFIRMATION
      dlg = Wx::MessageDialog.new(self.view, (ROLE_DELETE_CONFIRM_MSG % [role, user.given_name] ), 'Confirm Delete', Wx::OK|Wx::CANCEL|Wx::ICON_EXCLAMATION)
      if(dlg.show_modal == Wx::ID_OK)
        self.send_notification(NotificationName::DELETE_ROLE, role)
      end
    end
  end
  
end
# PureMVC Ruby Standard Demo - Employee Admin
# Ported to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
