require "fileutils"

module Builder
  class Readme
    def self.call(project_name)
      file_path = "#{project_name}/README.md"
      content = <<~HEREDOC
  # Readme
  This project was created by clean_arch gem.
HEREDOC

      FileUtils.mkdir_p(File.dirname(file_path))
      File.write(file_path, content)
    end
  end
end
