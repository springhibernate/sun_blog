class LogMine
  def LogMine.i(msg)
    msg=Time.new.strftime('%Y-%m-%d %H:%M:%S')+' '+msg
    File.open('log/mine.log','a+') do |file|
      file.puts msg
    end
  end
end