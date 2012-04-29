module Configuration

  def self.load(file)
    @config = (YAML.load_file(file)[Rails.env] || {}).with_indifferent_access
  end

  def self.method_missing(method, *args)
    raise "Configuration not loaded" unless @config

    if @config.has_key? method
      @config[method]
    else
      super
    end
  end

end

Configuration.load "#{Rails.root}/config/configuration.yml"
