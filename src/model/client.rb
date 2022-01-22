require 'socket'
include Socket::Constants

begin
    socket = Socket.new( AF_INET, SOCK_STREAM, 0 )
    sockaddr = Socket.pack_sockaddr_in( 2010, 'localhost' )
    socket.connect( sockaddr )
rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT
    puts 'Erro ao Conectar'
end

socket.puts "Hello from script 2."
puts "The server said, '#{socket.readline.chomp}'"
socket.close