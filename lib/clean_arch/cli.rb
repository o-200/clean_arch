# frozen_string_literal: true

require "thor"
require "fileutils"

require_relative "builder"

module CleanArch
  class CLI < Thor
    desc "new PROJECT_NAME", "Generate a new project with the specified name"
    def generate(project_name)
      project_path = File.join(Dir.pwd, project_name)

      raise Error, "Error: Directory #{project_name} already exists!" if Dir.exist?(project_path)

      create_structure(project_name)
      puts "Project #{project_name} has been successfully created!"
    end

    private

    def create_structure(project_name)
      objects_to_create = [
        { app: %i[controller repository use_case] },
        { config: %i[database main] },
        :readme,
        :gemfile,
        :config_ru
      ]

      # Builder::App::Controller, Builder::Gemfile...
      classes_to_generate = []

      objects_to_create.each do |obj|
        if obj.is_a?(Hash)
          obj.each_key do |key|
            obj[key].each do |n|
              classes_to_generate << Object.const_get("Builder::#{to_camel_case(key)}::#{to_camel_case(n)}")
            end
          end
        else
          classes_to_generate << Object.const_get("Builder::#{to_camel_case(obj)}")
        end
      end

      classes_to_generate.each { |klass| klass.call(to_camel_case(project_name.to_sym)) }
    end

    def to_camel_case(sym)
      sym.to_s.split("_").collect(&:capitalize).join
    end
  end
end
