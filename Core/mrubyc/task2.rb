PULSE_WIDTH_1 = 560 + 30
PULSE_WIDTH_2 = 2480 - 30
VR_MAX = 4095
DATA_MAX = 10

vr = ADC.new("PA0")             # 可変抵抗器 (VR)
servo = PWM.new("PB4")          # サーボモーター

servo.period_us( 10_000 )       # 10ms
servo.pulse_width_us( 0 )

# データ配列の準備
data = []
DATA_MAX.times {
  data << vr.read_raw
  sleep_ms 10
}

while true
  # VRから値取得しデータ配列へ
  data.shift
  data << vr.read_raw

  # 移動平均の計算
  avg = 0
  data.each {|d1| avg += d1 }
  avg /= data.size

  # Pulse width に換算して出力
  pw = PULSE_WIDTH_2 - (PULSE_WIDTH_2 - PULSE_WIDTH_1) * avg / VR_MAX
  servo.pulse_width_us( pw )

  sleep_ms 8
end
