# encoding: utf-8
require 'spec_helper'
require 'logstash/filters/ipcat'

describe LogStash::Filters::Ipcat do
  describe 'Ipcat filter' do
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

    sample('client' => nil) do
      expect(subject['ipcat']).to eq(nil)
    end
  end
end
