require "test_helper"

class CnpjAlfanumericoTest < Minitest::Test
  def test_normalizes_punctuation_and_lowercase
    assert_equal "12ABC34501DE35", Cnpj::Alfanumerico.normalize("12.abc.345/01de-35")
  end

  def test_maps_alphanumeric_values_using_ascii_minus_48
    assert_equal 0, Cnpj::Alfanumerico.char_value("0")
    assert_equal 9, Cnpj::Alfanumerico.char_value("9")
    assert_equal 17, Cnpj::Alfanumerico.char_value("A")
    assert_equal 42, Cnpj::Alfanumerico.char_value("Z")
  end

  def test_calculates_official_receita_example
    assert_equal "35", Cnpj::Alfanumerico.calculate_check_digits("12ABC34501DE")
    assert_equal "12ABC34501DE35", Cnpj::Alfanumerico.generate("12ABC34501DE")
    assert_equal "12.ABC.345/01DE-35", Cnpj::Alfanumerico.format("12ABC34501DE35")
    assert Cnpj::Alfanumerico.valid?("12.ABC.345/01DE-35")
  end

  def test_validates_legacy_numeric_cnpj
    assert Cnpj::Alfanumerico.valid?("11.444.777/0001-61")
    assert_equal "11.444.777/0001-61", Cnpj::Alfanumerico.format("11444777000161")
  end

  def test_rejects_invalid_values
    refute Cnpj::Alfanumerico.valid?("12.ABC.345/01DE-36")
    refute Cnpj::Alfanumerico.valid?("12.ABC.345/01DE-3X")
    assert_raises(ArgumentError) { Cnpj::Alfanumerico.calculate_check_digits("ABC") }
  end

  def test_splits_and_asserts_valid_cnpj
    assert_equal(
      { raiz: "12ABC345", ordem: "01DE", dv: "35" },
      Cnpj::Alfanumerico.split("12.ABC.345/01DE-35")
    )
    assert_equal "12ABC34501DE35", Cnpj::Alfanumerico.assert_valid!("12.ABC.345/01DE-35")
    assert_raises(ArgumentError) { Cnpj::Alfanumerico.assert_valid!("12.ABC.345/01DE-36") }
  end

  def test_detects_formatted_values
    assert Cnpj::Alfanumerico.formatted?("12.ABC.345/01DE-35")
    refute Cnpj::Alfanumerico.formatted?("12ABC34501DE35")
  end
end
