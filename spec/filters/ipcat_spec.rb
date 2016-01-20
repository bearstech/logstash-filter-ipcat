# encoding: utf-8
require 'spec_helper'
require 'logstash/filters/ipcat'

describe LogStash::Filters::Ipcat do
  describe 'Set to Hello World' do
    let(:config) do
      <<-CONFIG
      filter {
        ipcat {
          source => "client"
        }
      }
    CONFIG
    end

    sample('client' => '64.90.39.153') do
      expect(subject['ipcat']).to eq('http://www.dreamhost.com/')
    end

    sample('client' => '54.186.35.228') do
      expect(subject['ipcat']).to eq('http://www.amazon.com/aws/')
    end
  end
end
