# -*- encoding: utf-8 -*-
# stub: rails-admin-scaffold 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rails-admin-scaffold"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Kirill Kalachev"]
  s.date = "2014-11-23"
  s.description = "Rails generator which allows to scaffold admin controllers, views with proper (non-namespaced) models, helpers, tests and routes"
  s.email = ["dhampik@gmail.com"]
  s.homepage = "http://github.com/dhampik/rails-admin-scaffold"
  s.licenses = ["MIT"]
  s.rubyforge_project = "rails-admin-scaffold"
  s.rubygems_version = "2.4.8"
  s.summary = "Rails admin controllers scaffolding generator"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 4.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.2"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 4.0"])
      s.add_dependency(%q<bundler>, ["~> 1.2"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 4.0"])
    s.add_dependency(%q<bundler>, ["~> 1.2"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
