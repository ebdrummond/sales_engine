require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction'
require './lib/load_files'
 
class TransactionTest <MiniTest::Unit::TestCase

  # def test_create_transaction
  #   transaction = Transaction.new({"id" => 1, "invoice_id" => 2, "credit_card_number" => 3, "credit_card_expiration_date" => 4, "result" => 5, "created_at" => "2012-03-25 09:54:09 UTC", "updated_at" =>"2012-03-25 09:54:09 UTC"})
  #   assert_equal 1, transaction.id
  #   assert_equal 2, transaction.invoice_id
  #   assert_equal 3, transaction.credit_card_number
  #   assert_equal 4, transaction.credit_card_expiration_date
  #   assert_equal 5, transaction.result

  #   assert_equal Time.utc(2012, 3, 25, 9, 54, 9), transaction.created_at
  #   assert_equal Time.utc(2012, 3, 25, 9, 54, 9), transaction.updated_at 
  # end

  def test_trans_data_has_transactions
    data = LoadFiles.load_transactions_file
    assert_operator 1, :<=, data.length
  end
 
end