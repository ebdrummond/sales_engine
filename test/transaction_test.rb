require 'simplecov'
SimpleCov.start
require 'csv'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/transaction'
 
class TransactionTest <MiniTest::Unit::TestCase

  def setup
    transactions_file = CSV.open("./data/transactions.csv", headers: true)
    transactions= []

    transactions_file.each do |row|
      transactions<< Transaction.new(row)
    end
    Transaction.store(transactions)
  end

  # def test_trans_data_has_transactions
  #   data = LoadFiles.load_transactions_file
  #   assert_operator 1, :<=, data.length
  # end

  # ********************** Find By **********************

  def test_find_by_id
    transaction = Transaction.find_by_id(6)
    assert_equal 6, transaction.id
  end

  def test_find_by_invoice_id
    transaction = Transaction.find_by_invoice_id(10)
    assert_equal 10, transaction.invoice_id
  end

  def test_find_by_credit_card_number
    transaction = Transaction.find_by_credit_card_number(4580251236515201)
    assert_equal 4580251236515201, transaction.credit_card_number
  end

  def test_find_by_credit_card_expiration_date
    transaction = Transaction.find_by_credit_card_expiration_date("")
    assert_equal "", transaction.credit_card_expiration_date
  end

  def test_find_by_result
    transaction = Transaction.find_by_result("SUCCESS")
    assert_equal "success", transaction.result
  end

  def test_find_by_created_at
    transaction = Transaction.find_by_created_at(2012-03-27 14:54:09 UTC)
    assert_equal 2012-03-27 14:54:09 UTC, transaction.created_at
  end

  def test_find_by_updated_at
    transaction = Transaction.find_by_updated_at(2012-03-27 14:54:09 UTC)
    assert_equal 2012-03-27 14:54:09 UTC, transaction.updated_at
  end

  # ********************** Find All By **********************

  def test_find_all_by_id
    transaction = Transaction.find_all_by_id(8)
    assert_equal 1, transaction.count
  end

  def test_find_all_by_invoice_id
    transaction = Transaction.find_all_by_invoice_id(7)
    assert_equal 1, transaction.count
  end

  def test_find_all_by_credit_card_number
    transaction = Transaction.find_all_by_credit_card_number(4580251236515201)
    assert_equal 1, transaction.count
  end

  def test_find_all_by_credit_card_expiration_date
    transaction = Transaction.find_all_by_credit_card_expiration_date("")
    assert_equal 5595, transaction.count
  end

  def test_find_all_by_result
    transaction = Transaction.find_all_by_result("Success")
    assert_equal 4648, transaction.count
  end

  def test_find_all_by_created_at
    transaction = Transaction.find_all_by_created_at(2012-03-27 14:54:09 UTC)
    assert_equal 2, transaction.count
  end

  def test_find_all_by_updated_at
    transaction = Transaction.find_all_by_updated_at(2012-03-27 14:54:09 UTC)
    assert_equal 2, transaction.count
  end

  def test_finds_transaction_invoices
    invoices_file = CSV.open("./data/invoices.csv", headers: true)
    invoices = []

    invoices_file.each do |row|
    invoices << Invoice.new(row)
    end
    Invoice.store(invoices)

    transaction = Transaction.find_by_id(5)
    transaction.invoice
    assert_equal 6, transaction.invoice.id
  end

end
 
