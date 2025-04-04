module Builder
  class Gemfile
    def self.call(project_name)
      file_path = "#{project_name}/Gemfile"
      content = <<~HEREDOC
  # frozen_string_literal: true

  source 'https://rubygems.org' do
    gem 'sequel', '~> 5.88'
    gem 'sqlite3', '~> 2.5.0'

    gem 'puma', '~> 6.5'
    gem 'rack', '~> 3.1'

    gem 'roda'

    # gem 'interactor', '~> 3.1'

    # group :test do
    #   gem 'database_cleaner', '~> 2.1'
    #   gem 'database_cleaner-sequel'
    #   gem 'rack-test'
    #   gem 'rspec'
    # end

    # group :development do
    #   gem 'rubocop'
    #   gem 'rubocop-capybara'
    #   gem 'rubocop-rspec'
    #   gem 'rubocop-sequel'
    # end
  end
HEREDOC

      FileUtils.mkdir_p(File.dirname(file_path))
      File.write(file_path, content)
    end
  end
end
