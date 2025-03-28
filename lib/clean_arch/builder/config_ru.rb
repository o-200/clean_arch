module Builder
  class ConfigRu
    def self.call(project_name)
      file_path = "#{project_name}/config.ru"
      content = <<~HEREDOC
  # frozen_string_literal: true

  require_relative 'config/database/connection'
  require_relative 'config/main'

  DB = Config::Database::Connection.new.db

  run #{project_name}
HEREDOC

      FileUtils.mkdir_p(File.dirname(file_path))
      File.write(file_path, content)
    end
  end
end
