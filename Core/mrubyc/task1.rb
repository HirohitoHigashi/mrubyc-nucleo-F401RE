5.times do |i|
  puts "OK #{i}"
  sleep 0.5
end

uart6 = UART.new(6)

i = 0
while true
  n = uart6.bytes_available()
  crl = uart6.can_read_line()
  uart6.write("UART #{i+=1} '#{n} #{crl}'\n")

  if crl
    s = uart6.gets
    puts s
  end
  sleep 1
end
