require 'sqlite3'
require 'socket'

#a = Auto.new
#msg = a.wait_conex
#puts msg


class Auto
  attr_accessor :port
 
  def initialize

    # conecta no banco e carrega as principais variaveis
    # @ip
    @port = 2000
  end
 
  def wait_conex
      Socket.tcp_server_loop(2000) {|sock, client_addrinfo|
        begin
          IO.copy_stream(sock, sock)  
        ensure
          sock.close
        end
      }
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
  