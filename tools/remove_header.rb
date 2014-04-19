#!/usr/bin/env ruby

# print all the lines in every file passed via command line that contains login
sep_count = 0
ARGF.each do |line|
  if line =~ /---/
    sep_count += 1
    next
  end
  puts line if sep_count % 2 == 0
end

