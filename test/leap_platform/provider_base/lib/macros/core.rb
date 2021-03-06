# encoding: utf-8

module LeapCli
  module Macro

    #
    # return a fingerprint for a x509 certificate
    #
    def fingerprint(filename)
      "SHA256: " + X509.fingerprint("SHA256", Path.named_path(filename))
    end

    #
    # Creates a hash from the ssh key info in users directory, for use in
    # updating authorized_keys file. Additionally, the 'monitor' public key is
    # included, which is used by the monitor nodes to run particular commands
    # remotely.
    #
    def authorized_keys
      hash = {}
      keys = Dir.glob(Path.named_path([:user_ssh, '*']))
      keys.sort.each do |keyfile|
        ssh_type, ssh_key = File.read(keyfile, :encoding => 'UTF-8').strip.split(" ")
        name = File.basename(File.dirname(keyfile))
        hash[name] = {
          "type" => ssh_type,
          "key" => ssh_key
        }
      end
      ssh_type, ssh_key = File.read(Path.named_path(:monitor_pub_key), :encoding => 'UTF-8').strip.split(" ")
      hash[Leap::Platform.monitor_username] = {
        "type" => ssh_type,
        "key" => ssh_key
      }
      hash
    end

    def assert(assertion)
      if instance_eval(assertion)
        true
      else
        raise AssertionFailed.new(assertion)
      end
    end

    #
    # applies a JSON partial to this node
    #
    def apply_partial(partial_path)
      manager.partials(partial_path).each do |partial_data|
        self.deep_merge!(partial_data)
      end
    end

    #
    # If at first you don't succeed, then it is time to give up.
    #
    # try{} returns nil if anything in the block throws an exception.
    #
    # You can wrap something that might fail in `try`, like so.
    #
    #   "= try{ nodes[:services => 'tor'].first.ip_address } "
    #
    def try(&block)
      yield
    rescue NoMethodError
      nil
    end

    protected

    #
    # returns a node list, if argument is not already one
    #
    def listify(node_list)
      if node_list.is_a? Config::ObjectList
        node_list
      elsif node_list.is_a? Config::Object
        Config::ObjectList.new(node_list)
      else
        raise ArgumentError, 'argument must be a node or node list, not a `%s`' % node_list.class, caller
      end
    end

  end
end
