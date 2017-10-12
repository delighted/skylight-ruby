# Supports 0.2+, though Sinatra doesn't support 2.0, and Rails doesn't work with older versions
module Skylight
  module Probes
    module Tilt
      class Probe
        VIRTUAL_PATH_PREFIX_PTN = /^(app|lib|vendor)\/(views|assets)\//

        def install
          ::Tilt::Template.class_eval do
            alias render_without_sk render

            def render(*args, &block)
              opts = {
                category: "view.render.template",
                title: options[:sky_virtual_path] || infer_sky_virtual_path || "Unknown template name"
              }

              Skylight.instrument(opts) do
                render_without_sk(*args, &block)
              end
            end

            private

            def infer_sky_virtual_path
              if expanded_path = file && File.expand_path(file)
                Pathname.new(expanded_path)
                  .relative_path_from(Rails.root)
                  .to_s
                  .gsub(Skylight::Probes::Tilt::Probe::VIRTUAL_PATH_PREFIX_PTN, "")
              end
            end
          end
        end
      end
    end

    register("Tilt::Template", "tilt/template", Tilt::Probe.new)
  end
end
