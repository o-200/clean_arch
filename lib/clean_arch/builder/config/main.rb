module Builder
  module Config
    class Main
      def self.call(project_name)
        file_path = "#{project_name}/config/main.rb"
        content = <<~HEREDOC
  # frozen_string_literal: true

  require 'roda'

  module Config
    class Main < Roda
      plugin :json, classes: [Array, Hash]

      route do |r|
        r.root { { message: 'Welcome' } }
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
