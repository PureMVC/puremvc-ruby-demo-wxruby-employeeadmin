require 'rubygems'
require 'wx'

#Load PureMVC Framework (and any other libraries) from /lib
Dir['lib/**/init.rb'].each do |library|
  require library
end

#Then load EmployeeAdmin application from /src    
Dir['src/**/*.rb'].each do |app|
  require app
end

#Start the EmployeeAdmin application
WxApp.new().main_loop

# PureMVC Ruby Standard Demo - Employee Admin
# Ported to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
