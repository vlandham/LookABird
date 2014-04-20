#!/usr/bin/env ruby

# print all the lines in every file passed via command line that contains login
sep_count = 0
ARGF.each do |line|
  if line =~ /img\/(.*)\.png/
    line.gsub!($1, "#{$1}_large")
  end
  puts line
end

