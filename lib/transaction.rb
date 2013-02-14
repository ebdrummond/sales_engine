require 'csv'
require 'time'


class Transaction
  attr_reader :id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at

  def initialize(input)
    @id = input["id"].to_i
    @invoice_id = input["invoice_id"].to_i
    @credit_card_number = input["credit_card_number"].to_i
    @credit_card_expiration_date = input["credit_card_expiration_date"].to_i
    @result = input["result"].to_s
    @created_at = Time.parse(input["created_at"]).to_s
    @updated_at = Time.parse(input["updated_at"]).to_s
  end

  def self.store(transactions)
    @transactions = transactions
  end

  def to_s
    "#{@id} #{@invoice_id} #{@credit_card_number} #{@credit_card_expiration_date} #{@result} #{@created_at} #{@updated_at}"
  end

  def self.collection
    @transactions
  end

  # ***************************** Find By *****************************

  # id,invoice_id,credit_card_number,credit_card_expiration_date,result,
  # created_at,updated_at

  def self.find_by_id(id)
    collection.find{|transaction| transaction.id == id}
  end

  def self.find_by_invoice_id(invoice_id)
    collection.find{|transaction| transaction.invoice_id == invoice_id}
  end

  def self.find_by_credit_card_number(credit_card_number)
    collection.find{|transaction| transaction.credit_card_number == credit_card_number}
  end

  def self.find_by_credit_card_expiration_date
    collection.find{|transaction| transaction.credit_card_expiration_date == ""}
  end

  def self.find_by_result(result)
    collection.find{|transaction| transaction.result == result}
  end

  def self.find_by_created_at(created_at)
    collection.find{|transaction| transaction.created_at == created_at}
  end

  def self.find_by_updated_at(updated_at)
    collection.find{|transactions| transactions.updated_at == updated_at}
  end

  # ***************************** Find All By *****************************

  # id,invoice_id,credit_card_number,credit_card_expiration_date,result,
  # created_at,updated_at

  def self.find_all_by_id(id)
    collection.select{|transaction| transaction.id == id}
  end

  def self.find_all_by_invoice_id(invoice_id)
    collection.select{|transaction| transaction.invoice_id == invoice_id}
  end

  def self.find_all_by_credit_card_number(credit_card_number)
    collection.select{|transaction| transaction.credit_card_number == credit_card_number}
  end

  def self.find_all_by_credit_card_expiration_date
    collection.select{|transaction| transaction.credit_card_expiration_date == ""}
  end

  def self.find_all_by_result(result)
    collection.select{|transaction| transaction.result == result}
  end

  def self.find_all_by_created_at(created_at)
    collection.select{|transaction| transaction.created_at == created_at}
  end

  def self.find_all_by_updated_at(updated_at)
    collection.select{|transactions| transactions.updated_at == updated_at}
  end

  # ***************************** Random *****************************

  def self.random
    collection.sample
  end


end
