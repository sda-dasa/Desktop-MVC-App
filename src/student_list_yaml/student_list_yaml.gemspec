Gem::Specification.new do |spec|
  spec.name          = "students_list_yaml_saltykova"
  spec.version       = "0.1.0"
  spec.authors       = ["Saltykova Darya"]
  spec.email         = ["darya.5altykova@yandex.ru"]
  
  spec.summary       = "YAML-based student list management"
  spec.description   = "A gem for managing student lists using YAML format with full CRUD operations"
  spec.homepage      = "https://gitlab.com/DaryaSaltykova/students_list_yaml"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata = {
    "source_code_uri" => "https://gitlab.com/DaryaSaltykova/students_list_yaml"
  }

  spec.files         = Dir['lib/**/*.rb'] + ['README.md']
  spec.require_paths = ["lib"]

end
