# frozen_string_literal: true

class OperationGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def create_operation_file
    template 'operation.rb.txt', File.join('app/operations', class_path, "#{file_name}.rb")
    template 'operation_spec.rb.txt',
             File.join('spec/operations', class_path, "#{file_name}_spec.rb")
  end
end
