class UserForm < Wx::Panel
  attr_accessor :username, :fname, :lname, :email, :password, :confirm_password, 
    :department_combo, :add_btn, :cancel_btn, :mode, :user, :delegate
  
  MODE_ADD 	= "modeAdd"
  MODE_EDIT 	= "modeEdit"
  
  def initialize(parent)
    super(parent,3,Wx::Point.new(0,220), Wx::Size.new(330,300))

    vbox = Wx::BoxSizer.new(Wx::VERTICAL)
    hbox_bottom = Wx::BoxSizer.new(Wx::HORIZONTAL)
    grid = Wx::GridSizer.new(7,2,6,0)

    st1 = Wx::StaticText.new(self, -1, 'First Name') 
    @fname = Wx::TextCtrl.new(self, -1)
    evt_text(@fname) { | event | self.check_valid }
    grid.add(st1, 0, Wx::ALIGN_CENTER_VERTICAL)
    grid.add(@fname, 0, Wx::ALIGN_RIGHT | Wx::EXPAND)  

    st2 = Wx::StaticText.new(self, -1, 'Last Name')  
    @lname = Wx::TextCtrl.new(self, -1)
    evt_text(@lname) { | event | self.check_valid }
    grid.add(st2, 0, Wx::ALIGN_CENTER_VERTICAL)
    grid.add(@lname, 0, Wx::ALIGN_RIGHT | Wx::EXPAND)  

    st3 = Wx::StaticText.new(self, -1, 'Email')  
    @email = Wx::TextCtrl.new(self, -1)
    evt_text(@email) { | event | self.check_valid }
    grid.add(st3, 0, Wx::ALIGN_CENTER_VERTICAL)
    grid.add(@email, 0, Wx::ALIGN_RIGHT | Wx::EXPAND)  

    st4 = Wx::StaticText.new(self, -1, 'Username')  
    @username = Wx::TextCtrl.new(self, -1)
    evt_text(@username) { | event | self.check_valid }
    grid.add(st4, 0, Wx::ALIGN_CENTER_VERTICAL)
    grid.add(@username, 0, Wx::ALIGN_RIGHT | Wx::EXPAND)  

    st5 = Wx::StaticText.new(self, -1, 'Password')  
    @password = Wx::TextCtrl.new(self, -1)
    evt_text(@password) { | event | self.check_valid }
    grid.add(st5, 0, Wx::ALIGN_CENTER_VERTICAL)
    grid.add(@password, 0, Wx::ALIGN_RIGHT | Wx::EXPAND)  

    st6 = Wx::StaticText.new(self, -1, 'Confirm Password')  
    @confirm_password = Wx::TextCtrl.new(self, -1)
    evt_text(@confirm_password) { | event | self.check_valid }
    grid.add(st6, 0, Wx::ALIGN_CENTER_VERTICAL)
    grid.add(@confirm_password, 0, Wx::ALIGN_RIGHT | Wx::EXPAND)  

    st7 = Wx::StaticText.new(self, -1, 'Department')  
    @department_combo = Wx::ComboBox.new(self, -1)
    evt_combobox(@department_combo) { self.check_valid}
    grid.add(st7, 0, Wx::ALIGN_CENTER_VERTICAL)
    grid.add(@department_combo, 0, Wx::ALIGN_RIGHT | Wx::EXPAND)  
      
    @add_btn = Wx::Button.new(self, -1, "Add User", Wx::Point.new(-1,-1), Wx::Size.new(100,-1))
    @add_btn.disable
    evt_button(@add_btn.id) { self.on_add }
    @cancel_btn = Wx::Button.new(self, -1, "Cancel")
    evt_button(@cancel_btn) { self.on_cancel }
    
    vbox.add(grid, 0, Wx::ALL | Wx::EXPAND, 10)
		
    hbox_bottom.add(@add_btn, 0, Wx::RIGHT,10)
    hbox_bottom.add(@cancel_btn, 0, Wx::RIGHT,10)
    vbox.add(hbox_bottom, 0, Wx::BOTTOM|Wx::ALIGN_RIGHT,10)
    
    self.set_auto_layout(true)
    self.set_sizer(vbox)
    self.layout
  end
  
  def on_add
    if @mode == MODE_ADD
      self.delegate.on_add
    else
      self.delegate.on_update
    end
    self.check_valid
  end

  def on_cancel
    self.delegate.on_cancel
  end
  
  def update_user(user)
    @user = user
    @username.set_value(@user.username)
    @fname.set_value(@user.fname)
    @lname.set_value(@user.lname)
    @email.set_value(@user.email)
    @password.set_value(@user.password)
    @confirm_password.set_value(@user.password)
    @department_combo.set_value(user.department)
    self.check_valid
  end
  
  def update_department_combo(choices, default)
    @department_combo.clear
    @department_combo.append(choices)
    @department_combo.set_value(default)
  end

  def update_mode(mode)
    @mode = mode
    if @mode == MODE_ADD
      @add_btn.set_label("Add User")
    else
      @add_btn.set_label("Update User")
    end
  end
  
  def check_valid()
    if enable_submit(@username.get_value, @password.get_value, @confirm_password.get_value, @department_combo.get_value)
      @add_btn.enable
    else
      @add_btn.disable
    end
  end
  
  def enable_submit(u, p, c, d)
    return (!u.empty? && !p.empty? && !c.empty? && (p == c) && !(d == DeptList::DEPT_NONE_SELECTED))
  end
end
# PureMVC Ruby Standard Demo - Employee Admin
# Ported to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
