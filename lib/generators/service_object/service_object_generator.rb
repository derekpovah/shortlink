class ServiceObjectGenerator < Rails::Generators::Base
  argument :object_type, type: :string
  argument :name, type: :string
  class_option :rspec, type: :boolean, desc: 'DEFAULT: Use rspec as your test framework.'
  class_option :minitest, type: :boolean, desc: 'Use minitest as your test framework.'
  source_root File.expand_path('templates', __dir__)

  def copy_pattern
    template 'service_object.rb.erb', generated_file_path
  end

  def copy_pattern_test
    template "service_object_#{test_suite_name}.rb.erb", generated_test_file_path
  end

  private

  def class_name
    name.classify
  end

  def folder_name
    object_type.underscore.pluralize
  end

  def generated_file_path
    "app/#{folder_name}/#{name}.rb"
  end

  def generated_test_file_path
    "#{test_suite_name}/#{folder_name}/#{name}_#{test_suite_name}.rb"
  end

  def test_suite_name
    identifier = 'spec'
    identifier = 'test' if options.minitest?
    identifier
  end

  def test_type
    object_type.underscore
  end
end
