require_relative "lib/cnpj/alfanumerico/version"

Gem::Specification.new do |spec|
  spec.name = "cnpj-alfanumerico"
  spec.version = Cnpj::Alfanumerico::VERSION
  spec.authors = ["Miguel C. Honorio"]
  spec.email = ["miguel@prosulti.com.br"]

  spec.summary = "Validacao, calculo e formatacao de CNPJ numerico e alfanumerico."
  spec.description = "Implementa o calculo do digito verificador do CNPJ alfanumerico conforme a Receita Federal, mantendo compatibilidade com CNPJ numerico."
  spec.homepage = "https://github.com/miguelcarloshonorio/cpnj_ruby_2026"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.6"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.glob("{lib,test,exe,README.md,LICENSE,CHANGELOG.md}**/*").select { |path| File.file?(path) }
  spec.bindir = "exe"
  spec.executables = ["cnpj-alfanumerico"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "minitest", "~> 5.25"
  spec.add_development_dependency "rake", "~> 13.2"
end
