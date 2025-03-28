module Builder
  module App
    class Controller
      def self.call(project_name)
        file_path = "#{project_name}/controllers/application_controller.rb"
        content = <<~HEREDOC
  module App
    module Controllers
      class ApplicationController
        def parse_req_body(request)
          JSON.parse(request.body.read, symbolize_names: true)
        end
      end
    end
  end
HEREDOC

        FileUtils.mkdir_p(File.dirname(file_path))
        File.write(file_path, content)
      end
    end
  end
end
