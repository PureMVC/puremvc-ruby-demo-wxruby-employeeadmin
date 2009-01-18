class UserList < Wx::Panel
  attr_accessor :selected_user, :user_grid, :new_btn, :delete_btn, :users, :delegate
  
  def initialize(parent)
    super(parent,2,Wx::Point.new(-1,-1), Wx::Size.new(660,220))
    vbox = Wx::BoxSizer.new(Wx::VERTICAL)
    hbox_bottom = Wx::BoxSizer.new(Wx::HORIZONTAL)
    
    @user_grid = Wx::Grid.new(self, -1)
    evt_grid_select_cell(){ | event | self.on_select(event) }
    evt_grid_cell_change(){ | event | self.on_select(event) }
    @user_grid.create_grid(6,6)
    @user_grid.set_col_label_value(0, "Username")
    @user_grid.set_col_label_value(1, "First Name")
    @user_grid.set_col_label_value(2, "Last Name")
    @user_grid.set_col_label_value(3, "Email")
    @user_grid.set_col_label_value(4, "Department")
    @user_grid.set_col_label_value(5, "Password")
		
    @new_btn = Wx::Button.new(self, -1, "New")
    @delete_btn = Wx::Button.new(self, -1, "Delete")
    evt_button(@new_btn.id) { self.on_new }
    evt_button(@delete_btn.id) { self.on_delete }

    hbox_bottom.add(@new_btn, 0, Wx::RIGHT, 10)
    hbox_bottom.add(@delete_btn, 0, Wx::RIGHT, 10)
    
    vbox.add(@user_grid, 0, Wx::ALL|Wx::ALIGN_LEFT, 10)
    vbox.add(hbox_bottom, 0, Wx::TOP|Wx::BOTTOM|Wx::RIGHT|Wx::ALIGN_RIGHT,10)
    self.set_auto_layout(true)
    self.set_sizer(vbox)
    self.layout
  end
  
  def on_select(event)
    begin
      @selected_user = @users[event.get_row]
      @user_grid.select_row(event.get_row)
      event.skip
      self.delegate.on_select
    rescue
      #empty row
    end
  end
  
  def on_new
    self.delegate.on_new
    self.de_select
  end
  
  def on_delete
    if @selected_user
      self.delegate.on_delete
      self.de_select
    end
  end
  
  def update_user_grid(users)
    @user_grid.clear_grid
    @users = users
    users.each_with_index do |user, index|
      @user_grid.set_cell_value(index, 0, users[index].username)
      @user_grid.set_cell_value(index, 1, users[index].fname)
      @user_grid.set_cell_value(index, 2, users[index].lname)
      @user_grid.set_cell_value(index, 3, users[index].email)
      @user_grid.set_cell_value(index, 4, users[index].department)
      @user_grid.set_cell_value(index, 5, users[index].password)
    end
    @user_grid.auto_size
  end
  
  def de_select
    @user_grid.clear_selection
  end
  
end
# PureMVC Ruby Standard Demo - Employee Admin
# Ported to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
