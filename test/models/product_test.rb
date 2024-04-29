require "test_helper"

class ProductTest < ActiveSupport::TestCase

  test 'Should have a positive price' do
    product = products(:one)
    product.price = -1
    assert_not product.valid?
  end

  test 'should filter product by name' do
    assert_equal 2, Product.filter_by_title('tv').count
  end

  test 'Should filter product by name sorted' do
    assert_equal [products(:another_tv), products(:one)], Product.filter_by_title('tv').sort
  end

  test 'Should filter product by price above or equal 300' do
    assert_equal [products(:two), products(:one)], Product.above_or_equal(300).sort
  end

  test 'Should filter product by price below or equal 300' do
    assert_equal [products(:another_tv)], Product.below_or_equal(300).sort
  end
end
