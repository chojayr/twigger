#!/usr/bin/ruby -w

require 'rubygems'
require 'twitter'
require 'json'
require 'pp'
require 'zhabbix'

@tuts = Twitter::Client.new(
  :consumer_key => "###############",
  :consumer_secret => "###############################",
  :oauth_token => "#######################################",
  :oauth_token_secret => "########################################"
)

        a = Getterz::ZabGet.new.apiOutz
        getter = a.trigger.get(  { "filter" => { "priority" => [ 4, 5 ] },  "output" => "extend", "limit"=> 9, "only_true" => "true", "monitored" => 1, "withUnacknowledgedEvents" => 1,  "skipDependent" => 1, "expandData" => "host" } )

       outs = getter.to_json
       nas = JSON.parse(getter.to_json)
       score = []
       nas.each do |res|

          prio = res["priority"]
          match = res["description"]
          host = res["host"]
          lastchng = res["lastchange"]
          alertime = Time.at(lastchng.to_i)
          timelapse = Time.now - 1.hours
          time = Time.now
          #newarr = /([^.]+)/.match("#{host}")
          if  alertime >= timelapse
             score << /([^.]+)/.match("#{host}")
          end
      end


flat = score.join(", ")
#File.open("#{drctry}", "w") { |f| f.write("#{flat}") }

@tuts.update("high alert on: #{flat}")


