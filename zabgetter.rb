#!/usr/bin/ruby -w

require 'rubygems'
require 'json'
require 'pp'
require 'zbxapi'
require 'active_support/core_ext/numeric/time'
   
module Getterz
  class ZabGet 
    def apiOutz
       server = ZabbixAPI.new("https://zabbix.url.com/zabbix")
       server.login("zabbixusername","zabbixpassword")
       #return getter
    end
  end
end
