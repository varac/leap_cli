
module LeapCli
  module Commands

    desc 'Compile json files to hiera configs'
    command :compile do |c|
      c.action do |global_options,options,args|
        # these must come first
        update_compiled_ssh_configs

        # export generated files
        manager.export_nodes
        manager.export_secrets
      end
    end

    def update_compiled_ssh_configs
      update_authorized_keys
      update_known_hosts
    end

  end
end