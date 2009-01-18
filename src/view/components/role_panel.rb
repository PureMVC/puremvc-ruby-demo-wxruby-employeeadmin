class RolePanel < Wx::Panel
  attr_accessor :user, :role_list, :role_combo, :add_btn, :remove_button, :selected_role, :delegate
  
  def initialize(parent)
    super(parent,1,Wx::Point.new(330,220), Wx::Size.new(330,300))
    vbox = Wx::BoxSizer.new(Wx::VERTICAL)
    hbox_bottom = Wx::BoxSizer.new(Wx::HORIZONTAL)
    
    @role_list = Wx::ListBox.new(self, -1, Wx::Point.new(-1,-1), Wx::Size.new(300,200))
    @role_combo = Wx::ComboBox.new(self, -1)
    @add_btn = Wx::Button.new(self, -1, "Add")
    @add_btn.disable
    @remove_btn = Wx::Button.new(self, -1, "Remove")
    @remove_btn.disable
    
    evt_button(@add_btn) { self.delegate.on_add_role }
    evt_button(@remove_btn) { self.delegate.on_remove_role}
    evt_combobox(@role_combo) { self.on_combo_click}
    evt_listbox(@role_list) { self.on_list_click}
    
    hbox_bottom.add(@role_combo, 0, Wx::RIGHT,10)
    hbox_bottom.add(@add_btn, 0, Wx::RIGHT,10)
    hbox_bottom.add(@remove_btn, 0, Wx::RIGHT,10)
    vbox.add(@role_list, 1, Wx::TOP|Wx::CENTER,10)
    vbox.add(hbox_bottom, 0, Wx::TOP|Wx::BOTTOM|Wx::ALIGN_RIGHT,10)

    self.set_auto_layout(true)
    self.set_sizer(vbox)
    self.layout    
  end
  
  def update_role_list(items)
    @role_list.set(items)
  end
    
  def update_role_combo(choices, default)
    @role_combo.clear
    @role_combo.append(choices)
    @role_combo.set_value(default)
  end
    
  def on_combo_click
    if @role_combo.get_value != RoleList::ROLE_NONE_SELECTED
      @add_btn.enable
    else
      @add_btn.disable
    end
    @role_list.set_selection(-1)
    @selected_role = @role_combo.get_value
  end
    
  def on_list_click
    if @role_list.get_selection != RoleList::ROLE_NONE_SELECTED
      @remove_btn.enable
    else
      @remove_btn.disable
    end
    @role_combo.set_value(RoleList::ROLE_NONE_SELECTED)
    @selected_role = @role_list.get_string_selection
  end
  
end
# PureMVC Ruby Standard Demo - Employee Admin
# Ported to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License

