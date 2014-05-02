
Puppet::Type.type(:a2site).provide(:a2site) do
  
  desc "Manage Apache 2 sites on Debian and Ubuntu"

  optional_commands :encmd  => "a2ensite"
  optional_commands :discmd => "a2dissite"

  defaultfor :operatingsystem => [ :debian, :ubuntu ]
  
  #-----------------------------------------------------------------------------
  # Checks

  def exists?
    File.exists?("/etc/apache2/sites-enabled/" + resource[:name].to_s)
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
