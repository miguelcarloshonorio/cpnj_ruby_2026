# cnpj-alfanumerico-ruby

Gem Ruby para validar, calcular, gerar e formatar CNPJ numérico e alfanumérico conforme as regras publicadas pela Receita Federal para vigência a partir de julho de 2026.

## Compatibilidade

- Ruby `2.7`
- Ruby `3.0`
- Ruby `3.2`
- Ruby `3.3`
- Ruby `3.4`

O projeto usa apenas recursos básicos da linguagem e mantém CI para versões modernas do Ruby MRI.

## Instalação

```bash
gem install cnpj-alfanumerico
```

## Uso

```ruby
require "cnpj-alfanumerico"

Cnpj::Alfanumerico.calculate_check_digits("12ABC34501DE")
# "35"

Cnpj::Alfanumerico.generate("12ABC34501DE")
# "12ABC34501DE35"

Cnpj::Alfanumerico.format("12ABC34501DE35")
# "12.ABC.345/01DE-35"

Cnpj::Alfanumerico.valid?("12.ABC.345/01DE-35")
# true
```

## API

- `Cnpj::Alfanumerico.normalize(value)`
- `Cnpj::Alfanumerico.char_value(char)`
- `Cnpj::Alfanumerico.calculate_check_digits(base12)`
- `Cnpj::Alfanumerico.generate(base12)`
- `Cnpj::Alfanumerico.valid?(cnpj)`
- `Cnpj::Alfanumerico.assert_valid!(cnpj)`
- `Cnpj::Alfanumerico.format(cnpj)`
- `Cnpj::Alfanumerico.formatted?(cnpj)`
- `Cnpj::Alfanumerico.split(cnpj)`

## CLI

```bash
exe/cnpj-alfanumerico validate 12.ABC.345/01DE-35
exe/cnpj-alfanumerico generate 12ABC34501DE
```

## Publicação

```bash
gem build cnpj-alfanumerico.gemspec
gem push cnpj-alfanumerico-0.1.2.gem
```

Para release automatizada via GitHub Actions, publique uma tag no formato `vX.Y.Z` que corresponda exatamente a `Cnpj::Alfanumerico::VERSION`.

## Referências

- Receita Federal: projeto CNPJ alfanumérico
- Receita Federal: manual de cálculo do DV
