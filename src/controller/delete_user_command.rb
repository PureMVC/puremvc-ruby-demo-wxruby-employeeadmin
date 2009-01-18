class DeleteUserCommand < SimpleCommand
  def execute(note)
    user_proxy = self.facade.retrieve_proxy(UserProxy::NAME)
    role_proxy = self.facade.retrieve_proxy(RoleProxy::NAME)
    [user_proxy, role_proxy].each do |proxy|
      proxy.delete_item(note.body)
    end
    self.facade.send_notification(NotificationName::USER_DELETED)
  end
end
# PureMVC Ruby Standard Demo - Employee Admin
# Ported to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
