require 'rubygems'

# IRB Options
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:EVAL_HISTORY] = 200

# Log to STDOUT if in Rails
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
  #IRB.conf[:USE_READLINE] = true

  # Display the RAILS ENV in the prompt
  # ie : [Development]>> 
  IRB.conf[:PROMPT][:CUSTOM] = {
   :PROMPT_N => "#{ENV["PWD"].split('/').pop} #{ENV["RAILS_ENV"]} > ",
   :PROMPT_I => "#{ENV["PWD"].split('/').pop} #{ENV["RAILS_ENV"]} > ",
   :PROMPT_S => nil,
   :PROMPT_C => "?> ",
   :RETURN => "=> %s\n"
   }
  # Set default prompt
  IRB.conf[:PROMPT_MODE] = :CUSTOM
end

# Find self in most Rails apps.
def me
  User.first
end

def history
  puts Readline::HISTORY.entries.split("exit").last[0..-2].join("\n")
end
