lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "one_shot/version"

Gem::Specification.new do |spec|
  spec.name          = "one_shot"
  spec.version       = OneShot::VERSION
  spec.authors       = ["Marc Siegel"]
  spec.email         = ["marc@usainnov.com"]

  spec.summary       = "Ruby one-shot parser of large json files represented as nested lazy enumerators."
  spec.description   = "Look, if you had one shot, or one opportunity, to parse everything you wanted out of an arbitrarily large json file, would you capture it? Or just let it slip?"
  spec.homepage      = "https://github.com/ms-ati/one_shot"

  spec.metadata["homepage_uri"]    = "https://github.com/ms-ati/one_shot"
  spec.metadata["source_code_uri"] = "https://github.com/ms-ati/one_shot"
  spec.metadata["changelog_uri"]   = "https://github.com/ms-ati/one_shot/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.8"
end
