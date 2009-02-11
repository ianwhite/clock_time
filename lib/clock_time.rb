require 'rubygems'
require 'active_support'

module ClockTime
  TwelveHour = /^at_([1-9]|10|11|12)(am|pm)$/
  TwentyFourHour = /^at_([0-1]\d|2[0-3])([0-5]\d)$/
  
  def self.included(time_class)
    time_class.class_eval do
      extend ClassMethods
      %w(respond_to? method_missing).each {|m| alias_method_chain m, :clock_time}
    end
  end
  
  module ClassMethods
    def tomorrow
      now + 1.day
    end
    
    def yesterday
      now - 1.day
    end
  end
  
  def respond_to_with_clock_time?(method)
    respond_to_without_clock_time?(method) || method.to_s =~ TwelveHour || method.to_s =~ TwentyFourHour
  end
  
private
  def method_missing_with_clock_time(method, *args, &block)
    if method.to_s =~ TwelveHour
      hour = ($1 == '12') ? 0 : $1.to_i
      hour += 12 if $2 == 'pm'
      self.at_midnight + hour.hours
    elsif method.to_s =~ TwentyFourHour
      hour, min = $1.to_i, $2.to_i
      self.at_midnight + hour.hours + min.minutes
    else
      method_missing_without_clock_time(method, *args, &block)
    end
  end

  module Version
    Major = 0
    Minor = 1
    Tiny  = 0
    
    String = [Major, Minor, Tiny].join('.')
  end
end

class Time
  include ClockTime
end