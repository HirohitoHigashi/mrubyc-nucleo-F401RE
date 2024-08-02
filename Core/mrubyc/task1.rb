uart6 = UART.new(6)

def split_ddmm( s )
  idx = s.index(".").to_i - 2
  raise "Format error" if idx <= 0

  s[idx,0] = " "
  return s
end

while true
  s = uart6.gets
  next if !s.start_with?("$GNRMC")

  rmc = s.split(",")
  next if rmc[2] != "A"

  # 日付(UTC)
  day = rmc[9][0,2].to_i
  mon = rmc[9][2,2].to_i
  year = rmc[9][4,2].to_i + 2000

  # 時刻(UTC)
  hour = rmc[1][0,2].to_i
  min = rmc[1][2,2].to_i
  sec = rmc[1][4,2].to_i

  # 緯度
  south_north = {"N"=>"+", "S"=>"-"}[rmc[4]]
  latitude = split_ddmm(rmc[3])

  # 経度
  east_west = {"E"=>"+", "W"=>"-"}[rmc[6]]
  longitude = split_ddmm(rmc[5])

  printf("%d/%2d/%2d %2d:%02d:%02d(UTC) Lat,Long: %s%s, %s%s\n",
         year, mon, day, hour, min, sec,
         south_north, latitude, east_west, longitude )
end
