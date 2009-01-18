class RolePanelMediator < Mediator
  NAME = 'RolePanelMediator'
  attr_accessor :role_proxy
  
  def initialize(view)
    super(NAME, view)
    @role_proxy = self.facade.retrieve_proxy(RoleProxy::NAME)
    self.view.update_role_combo(RoleList::ALL, RoleList::ROLE_NONE_SELECTED)
  end
  
  def on_register
    self.view.delegate = self
  end

  def on_add_role
    result = @role_proxy.add_role_to_user(self.view.user, self.view.selected_role)
    self.send_notification(NotificationName::ADD_ROLE_RESULT, result)
  end
  
  def on_remove_role
    @role_proxy.remove_role_from_user(self.view.user, self.view.selected_role)
    self.view.update_role_list(@role_proxy.get_user_roles(self.view.user.username))
  end
  
  def list_notification_interests
    [
      NotificationName::NEW_USER,
      NotificationName::USER_ADDED,
      NotificationName::USER_UPDATED,
      NotificationName::USER_DELETED,
      NotificationName::CANCEL_SELECTED,
      NotificationName::USER_SELECTED,
      NotificationName::ADD_ROLE_RESULT
    ]
  end
  
  def handle_notification(note)
    case note.name
    when NotificationName::NEW_USER
      clear_form
    when NotificationName::USER_ADDED
      self.view.user = note.body
      @role_proxy.add_item(RoleVO.new(self.view.user.username))
      clear_form
    when NotificationName::USER_UPDATED
      clear_form
    when NotificationName::USER_DELETED
      clear_form
    when NotificationName::CANCEL_SELECTED
      clear_form
    when NotificationName::USER_SELECTED
      self.view.user = note.body
      self.view.update_role_list(@role_proxy.get_user_roles(self.view.user.username))
    when NotificationName::ADD_ROLE_RESULT
      self.view.update_role_list(@role_proxy.get_user_roles(self.view.user.username))
    end
  end
  
  def clear_form
    self.view.user = nil
    self.view.update_role_list([])
    self.view.role_combo.set_string_selection(RoleList::ROLE_NONE_SELECTED)
  end
  
end
# PureMVC Ruby Standard Demo - Employee Admin
# Ported to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
