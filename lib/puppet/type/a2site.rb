Puppet::Type.newtype(:a2site) do
    @doc = "Manage Apache 2 sites on Debian and Ubuntu"

    ensurable

    newparam(:name) do
       desc "The name of the module to be managed"

       isnamevar

    end

    autorequire(:package) { catalog.resource(:package, 'apache')}

end