class StartupCommand < SimpleCommand
  
  def execute(note)
    [UserProxy.new, RoleProxy.new].each do |proxy|
      self.facade.register_proxy(proxy)
    end

    main_panel = note.body
    [
      DialogMediator.new(main_panel),
      UserFormMediator.new(main_panel.user_form),
      UserListMediator.new(main_panel.user_list),
      RolePanelMediator.new(main_panel.role_panel),
    ].each do |mediator|
      self.facade.register_mediator(mediator)
    end
  end
  
end
# PureMVC Ruby Standard Demo - Employee Admin
# Ported to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
