class DialogMediator < Mediator
  NAME = 'DialogMediator'
  
  def initialize(view)
    super(NAME, view)
  end
  
  def list_notification_interests
    [NotificationName::SHOW_DIALOG]
  end
  
  def handle_notification(note)
    if note.name == NotificationName::SHOW_DIALOG
      Wx::MessageDialog.new(self.view, note.body, 'Alert', Wx::OK|Wx::ICON_EXCLAMATION).show_modal
    end
  end
  
end
# PureMVC Ruby Standard Demo - Employee Admin
# Ported to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
