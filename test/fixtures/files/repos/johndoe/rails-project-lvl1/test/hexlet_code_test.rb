# frozen_string_literal: true

require_relative 'test_helper'

# Class HexletCodeTest
class HexletCodeTest < Minitest::Test
  def test_that_it_has_a_version
    assert_not_nil ::HexletCode::VERSION
  end

  User1 = Struct.new :name, :job, :gender, keyword_init: true
  User2 = Struct.new :name, :age, :job, :gender, :citizenship, keyword_init: true

  def test_simple_form
    user = User1.new name: 'rob', job: 'hexlet', gender: 'm'
    expected = read_fixture_file('form_simple.html')

    form = HexletCode.form_for user do |f|
      f.input :name
      f.input :job, as: :text
      f.input :gender, as: :select, collection: %w[m f]
      f.submit
    end

    assert_equal expected, form
  end

  def test_complex_form
    user = User2.new name: 'vika', age: 39, job: 'google', citizenship: %w[russia england]
    expected = read_fixture_file('form_complex.html')
    form = HexletCode.form_for user, url: '/users/1' do |f|
      f.input :name
      f.input :age
      f.input :job, as: :text
      f.input :citizenship, as: :select, multiple: true, collection: %w[russia germany england usa]
      f.submit
    end
    assert_equal expected, form
  end
end
