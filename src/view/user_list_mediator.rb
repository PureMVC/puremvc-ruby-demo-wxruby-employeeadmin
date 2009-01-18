class UserListMediator < Mediator
  NAME = 'UserListMediator'
  
  attr_accessor :user_proxy
  
  def initialize(view)
    super(NAME, view)
    @user_proxy = self.facade.retrieve_proxy(UserProxy::NAME)
    self.view.update_user_grid(@user_proxy.get_users)
  end
  
  def on_register
    self.view.delegate = self
  end
  
  def list_notification_interests
    [NotificationName::CANCEL_SELECTED, NotificationName::USER_UPDATED, 
      NotificationName::USER_ADDED, NotificationName::USER_DELETED]
  end
  
  def handle_notification(note)
    self.view.de_select
    self.view.update_user_grid(@user_proxy.get_users)
  end

  def on_select
    self.send_notification(NotificationName::USER_SELECTED, self.view.selected_user)
  end
  
  def on_new
    self.send_notification(NotificationName::NEW_USER, UserVO.new)
  end
  
  def on_delete
    self.send_notification(NotificationName::DELETE_USER,self.view.selected_user)
  end
end

# PureMVC Ruby Standard Demo - Employee Admin
# Ported to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
