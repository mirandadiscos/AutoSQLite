require 'sqlite3'
require 'socket'
include Socket::Constants


class Auto
  
  def initialize
    # conecta no banco e carrega as principais variaveis
    @ip = '127.0.0.1'
    @port = 2000
  end
  
  # As funções a seguir referece a conexões em que o Auto precisa ser Server
  def waiting_connection
    @socket = Socket.new( AF_INET, SOCK_STREAM, 0 )
    @sockaddr = Socket.pack_sockaddr_in( @port, @ip )
    @socket.bind( @sockaddr )
    @socket.listen( 7 )
    @client_fd, @client_addrinfo = @socket.sysaccept
    @server = 1
    @client_socket = Socket.for_fd( @client_fd )
    return 'Connected'
  end

  def send_msg(msg)
    @client_socket.puts msg
  end
  
  def received_msg
    return  @client_socket.readline.chomp
  end

  def close_connections
    if @server == 1
      @socket.close
    else
      @client_socket.close
    end
    return 'Connection ends'
  end

  def close!
    close_connections
  end
  # Fim das funções para o Auto funcionar como servidor
  
  # As funções a Seguir funcionará como client
  def client_connect
    begin
      @client_socket = Socket.new( AF_INET, SOCK_STREAM, 0 )
      @sockaddr = Socket.pack_sockaddr_in( @port, @ip )
      @client_socket.connect( @sockaddr )
      @server = 0
    rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT
        puts 'Connecting error'
    end
  end


  def gravalog
    
  end

  def record_results
    
    # o resultado tem um codigo de barras, um código de identificação, um valor(numerico ou string),Unidade de medida e possiveis Flags
    # se valor r string gravamos sempre normal, se não tiver ranges, também gravar como normal
    # as Flags são pertinentes a amostra como um todo
    # um código de barras tem varios códigos e varios exames, com diferentes unidades de medidas
  end

  def apply_status(id,result)
    id = 1
    db = SQLite3::Database.open "db/auto.db"
    db.results_as_hash = true
    valref = db.execute "SELECT idade_inicio,idade_fim,init_anorm, init_norm,final_norm,final_anorm, sex FROM valref where id = '#{id}'"
    valref = valref[0].to_h
    db.close


   # entre init_norm e final_norm = normal
   # entre init_anorm e init_norm = alterado
   # entre final_norm e final_anorm = alterado
   # menor que init_anorm = absurdo
   # maior que final_anorm = absurdo
    # a gravação precisa ter um status
    # status corresponde a:  normal, alterado e absurdo
    # o status deve estar dentro do range de normal init_norm e end_form
    # alterado está entre init_anorm e init_norm ou entre end_norm e end_anorm
    # fora desses ranges é considerado absurdo
end
end