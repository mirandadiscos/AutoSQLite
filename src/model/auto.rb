require 'sqlite3'
require 'socket'
include Socket::Constants

class Auto
  attr_accessor :port
 
  def initialize

    # conecta no banco e carrega as principais variaveis
    # @ip
    @port = 2000
  end
 
  def waiting_connection
    socket = Socket.new( AF_INET, SOCK_STREAM, 0 )
    sockaddr = Socket.pack_sockaddr_in( @port, '127.0.0.1' )
    socket.bind( sockaddr )
    socket.listen( 5 )
    client_fd, client_addrinfo = socket.sysaccept
    return client_socket = Socket.for_fd( client_fd )
  end
end
  
#    while (session = server.accept)
#      command = server.gets
#      if command.nil?
#        next
#      else
#        puts command
#      end
#    end
#  end

  def record_results
    # a gravação precisa ter um status
    # status corresponde a:  normal, alterado e absurdo
    # o status deve estar dentro do range de normal init_norm e end_form
    # alterado está entre init_anorm e init_norm ou entre end_norm e end_anorm
    # fora desses ranges é considerado absurdo
    # o resultado tem um codigo de barras, um código de identificação, um valor(numerico ou string),Unidade de medida e possiveis Flags
    # se valor for string gravamos sempre normal, se não tiver ranges, também gravar como normal
    # as Flags são pertinentes a amostra como um todo
    # um código de barras tem varios códigos e varios exames, com diferentes unidades de medidas
  end

  def send_message(msg)
    # envia dados para cliente

  end
end
  