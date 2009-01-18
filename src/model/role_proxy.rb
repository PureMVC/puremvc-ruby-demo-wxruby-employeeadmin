class RoleProxy < Proxy
  NAME = "RoleProxy"
  
  def initialize
    super(NAME, [])
    self.add_item(RoleVO.new('lstooge', [RoleList::ROLE_PAYROLL,RoleList::ROLE_EMP_BENEFITS]))
    self.add_item(RoleVO.new('cstooge', [RoleList::ROLE_ACCT_PAY,RoleList::ROLE_ACCT_RCV,RoleList::ROLE_GEN_LEDGER]))
    self.add_item(RoleVO.new('mstooge', [RoleList::ROLE_INVENTORY,RoleList::ROLE_PRODUCTION,RoleList::ROLE_SALES,RoleList::ROLE_SHIPPING]))
  end
  
  def get_roles
    self.data
  end
  
  def add_item(item)
    self.data << item
  end
 
  def delete_item(user)
    get_roles.delete_if{|x| x.username == user.username}
  end
  
  def does_user_have_role(user, role)
    has_role = false
    user = get_roles.detect{|x| x.username == user.username}
    has_role = true if user.roles.detect{|r| r == role}
    return has_role
  end
  
  def add_role_to_user(user, role)
    user = get_roles.detect{|r| r.username == user.username}
    if user && !does_user_have_role(user, role)
      user.roles << role
    end
  end
  
  def remove_role_from_user(user, role)
    user = get_roles.detect{|r| r.username == user.username}
    if user && does_user_have_role(user, role)
      user.roles.delete_if{|x| x == role}
    end
  end
  
  def get_user_roles(username)
    get_roles.detect{|x| x.username == username}.roles
  end
  
end
# PureMVC Ruby Standard Demo - Employee Admin
# Ported to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
