class UserFormMediator < Mediator
  NAME = 'UserFormMediator'
  attr_accessor :user_proxy
  
  def initialize(view)
    super(NAME, view)
    @user_proxy = self.facade.retrieve_proxy(UserProxy::NAME)
    self.view.update_department_combo(DeptList::ALL, DeptList::DEPT_NONE_SELECTED)
  end
  
  def on_register
    self.view.delegate = self
  end
  
  def list_notification_interests
    [NotificationName::NEW_USER, NotificationName::USER_DELETED, NotificationName::USER_SELECTED ]
  end
  
  def handle_notification(note)
    note_name = note.name
    case note_name
    when NotificationName::NEW_USER
      self.view.update_mode(self.view.class::MODE_ADD)
      clear_form
      self.view.fname.set_focus
    when NotificationName::USER_DELETED
      self.view.user = nil
      clear_form
    when NotificationName::USER_SELECTED
      self.view.update_user(note.body)
      self.view.update_mode(self.view.class::MODE_EDIT)
    end
  end
  
  def clear_form
    self.view.username.set_value('')
    self.view.fname.set_value('')
    self.view.lname.set_value('')
    self.view.email.set_value('')
    self.view.password.set_value('')
    self.view.confirm_password.set_value('')
    self.view.department_combo.set_value(DeptList::DEPT_NONE_SELECTED)
  end
  
  def on_add
    user = UserVO.new(self.view.username.get_value, self.view.fname.get_value,
      self.view.lname.get_value, self.view.email.get_value, self.view.password.get_value,
      self.view.department_combo.get_value)
    self.view.user = user
    @user_proxy.add_item(user)
    self.send_notification(NotificationName::USER_ADDED, user)
    clear_form
  end
  
  def on_update
    user = UserVO.new(self.view.username.get_value, self.view.fname.get_value,
      self.view.lname.get_value, self.view.email.get_value, self.view.password.get_value, 
      self.view.department_combo.get_value)
    self.view.user = user
    @user_proxy.update_item(user)
    self.send_notification(NotificationName::USER_UPDATED, user)
    clear_form
  end
  
  def on_cancel
    self.send_notification(NotificationName::CANCEL_SELECTED)
    clear_form
  end
  
end
# PureMVC Ruby Standard Demo - Employee Admin
# Ported to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License

