require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer'

class CustomerTest <MiniTest::Unit::TestCase

  def test_create_customer
    customer = Customer.new({"id" => 1, "first_name" => 2, "last_name" => 3, "created_at" => "2012-03-25 09:54:09 UTC", "updated_at" =>"2012-03-25 09:54:09 UTC"})
    assert_equal 1, customer.id
    assert_equal 2, customer.first_name
    assert_equal 3, customer.last_name
    assert_equal Time.utc(2012, 3, 25, 9, 54, 9), customer.created_at
    assert_equal Time.utc(2012, 3, 25, 9, 54, 9), customer.updated_at 
  end

end