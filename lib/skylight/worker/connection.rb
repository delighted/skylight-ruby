module Skylight
  module Worker
    class Connection
      attr_reader :sock

      def initialize(sock)
        @sock = sock
        @rem  = nil
        @buf  = nil
      end

      def read
        chunk = @sock.read_nonblock(CHUNK_SIZE)
        p [ chunk ]
        nil
      rescue Errno::EAGAIN
      end

    end
  end
end
