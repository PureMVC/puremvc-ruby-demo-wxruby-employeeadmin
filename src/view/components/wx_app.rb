class WxApp < Wx::App
  attr_accessor :app_frame
  
  def on_init
    @app_frame = AppFrame.new
    @app_frame.show
    AppFacade.instance.send_notification(NotificationName::STARTUP, @app_frame)
  end
  
end
# PureMVC Ruby Standard Demo - Employee Admin
# Ported to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
