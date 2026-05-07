# Changelog

## 0.1.5

- Corrige o empacotamento da gem para incluir os arquivos em `lib/cnpj/**`.
- Resolve o `LoadError` ao carregar a gem em projetos Rails e Ruby `3.4`.

## 0.1.4

- Passa a usar o environment `PROD` no workflow de publish para consumir `RUBYGEMS_AUTH_TOKEN` com escopo explícito.
- Alinha a próxima tag de release ao fluxo final de publicação automática no RubyGems.

## 0.1.3

- Atualiza os workflows do GitHub Actions para `actions/checkout@v5` e `ruby/setup-ruby@v1`.
- Corrige compatibilidade do CI com `ubuntu-24.04` e versões Ruby `3.3` e `3.4`.
- Mantém o fluxo de release baseado em tag com a infraestrutura de CI já corrigida.

## 0.1.2

- Simplifica a execução do CI para rodar testes sem depender de Bundler no GitHub Actions.
- Alinha a próxima tag de release com os workflows corrigidos de teste e publicação.

## 0.1.1

- Adiciona `Gemfile` para integração mais previsível com Bundler e GitHub Actions.
- Atualiza a matriz de CI para Ruby `2.7`, `3.0`, `3.2`, `3.3` e `3.4`.
- Ajusta o workflow de release para publicar apenas por tag de versão.
- Documenta suporte oficial às versões modernas do Ruby.

## 0.1.0

- Primeira versão com cálculo de DV, validação, geração e formatação de CNPJ numérico e alfanumérico.
