module Builder
  module Config
    class Database
      def self.call(project_name)
        file_path = "#{project_name}/config/database/connection.rb"
        content = <<~HEREDOC
  # frozen_string_literal: true

  require 'sequel'
  require 'logger'

  module Config
    module Database
      class Connection
        attr_reader :db

        def initialize
          @db = Sequel.sqlite('./config/database/database.db', logger: Logger.new($stdout))
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
