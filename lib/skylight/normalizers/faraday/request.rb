module Skylight
  module Normalizers
    module Faraday
      class Request < Normalizer
        register "request.faraday"

        def normalize(_trace, _name, payload)
          uri = payload[:url]

          opts = Formatters::HTTP.build_opts(payload[:method], uri.scheme,
          uri.host, uri.port, uri.path, uri.query)
          description = opts[:title]

          [opts[:category], "Faraday", description]
        end
      end
    end
  end
end
