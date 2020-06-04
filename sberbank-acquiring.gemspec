# -*- encoding: utf-8 -*-
# stub: sberbank-acquiring 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "sberbank-acquiring".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "TODO: Set to 'http://mygemserver.com'", "changelog_uri" => "TODO: Put your gem's CHANGELOG.md URL here.", "homepage_uri" => "https://github.com/Ranger-X/sberbank-acquiring", "source_code_uri" => "https://github.com/Ranger-X/sberbank-acquiring" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["RangerX".freeze]
  s.bindir = "exe".freeze
  s.date = "2019-07-19"
  s.email = ["rangerx.1985@gmail.com".freeze]
  s.files = [".gitignore".freeze, ".rspec".freeze, ".travis.yml".freeze, "CODE_OF_CONDUCT.md".freeze, "Gemfile".freeze, "Gemfile.lock".freeze, "LICENSE.txt".freeze, "README.md".freeze, "Rakefile".freeze, "bin/console".freeze, "bin/setup".freeze, "lib/sberbank/acquiring.rb".freeze, "lib/sberbank/acquiring/client.rb".freeze, "lib/sberbank/acquiring/constants.rb".freeze, "lib/sberbank/acquiring/exception.rb".freeze, "lib/sberbank/acquiring/gateway.rb".freeze, "lib/sberbank/acquiring/service_base.rb".freeze, "lib/sberbank/acquiring/service_rest.rb".freeze, "lib/sberbank/acquiring/url_helper.rb".freeze, "lib/sberbank/acquiring/util.rb".freeze, "lib/sberbank/acquiring/version.rb".freeze, "sberbank-acquiring.gemspec".freeze]
  s.homepage = "https://github.com/Ranger-X/sberbank-acquiring".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.11".freeze
  s.summary = "Sberbank internet acquiring API gem".freeze

  s.installed_by_version = "2.6.11" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.17"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.17"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<minitest>.freeze, ["~> 5.0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.17"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.0"])
  end
end
