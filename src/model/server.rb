require 'pry'
require 'socket'
include Socket::Constants

#---- Setando protocolo e o tipo de comunicação: ----#
socket = Socket.new( AF_INET, SOCK_STREAM, 0 )
#AF_INET = IPv4 protocol
#The type of communications between the two endpoints
#SOCK_STREAM: A stream socket provides a sequenced, reliable two-way connection for a byte stream 

#---- Server: Embala IP E Porta como uma string de endereço socket
sockaddr = Socket.pack_sockaddr_in( 2200, '127.0.0.1' )
binding.pry
#---- Vincula-se ao endereço fornecido
socket.bind( sockaddr )
#---- Ouve as conexões, usando um inteiro como backlog @backlog tamanho maximo da fila para conexões pendentes
    socket.listen( 5 )
    #---- Aceita a conexão, retornando uma matriz contendo o arquivo descrito para a conexão
    client_fd, client_addrinfo = socket.sysaccept
    #---- Retorna um objeto socket que contém o descritor de arquivo, fd. 
    client_socket = Socket.for_fd( client_fd )

    loop do
    puts "[received]: '#{client_socket.readline.chomp}'"
    client_socket.puts "[send] :"
    end

    socket.close
