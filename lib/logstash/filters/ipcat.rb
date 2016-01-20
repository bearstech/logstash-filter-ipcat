# encoding: utf-8
require 'logstash/filters/base'
require 'logstash/namespace'
require 'ipcat'

class LogStash::Filters::Ipcat < LogStash::Filters::Base
  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #   example {
  #     message => "My message..."
  #   }
  # }
  #
  config_name 'ipcat'

  config :source, validate: :string, required: true
  config :target, validate: :string, default: 'ipcat'

  public

  def register
    path = ::File.expand_path('../../../vendor/datacenters.csv', ::File.dirname(__FILE__))
    @datacenters = IPCat::Datacenters.new path
  end # def register

  public

  def filter(event)
    d = @datacenters.find(event[@source])
    event[@target] = d

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Ipcat
