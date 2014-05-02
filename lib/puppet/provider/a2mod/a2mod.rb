
Puppet::Type.type(:a2mod).provide(:a2mod) do
  
  desc "Manage Apache 2 modules on Debian and Ubuntu"

  optional_commands :encmd  => "a2enmod"
  optional_commands :discmd => "a2dismod"

  defaultfor :operatingsystem => [ :debian, :ubuntu ]
  
  #-----------------------------------------------------------------------------
  # Checks

  def exists?
    File.exists?("/etc/apache2/mods-enabled/" + resource[:name].to_s + ".load")
  end
   
  #-----------------------------------------------------------------------------
  # Operations

  def create
    encmd resource[:name]
  end
  
  #---

  def destroy
    discmd resource[:name]
  end
end
