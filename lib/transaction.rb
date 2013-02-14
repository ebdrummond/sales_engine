require 'csv'
require 'time'


class Transaction
  attr_reader :id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at

  def initialize(input)
    @id = input["id"]
    @invoice_id = input["invoice_id"]
    @credit_card_number = input["credit_card_number"]
    @credit_card_expiration_date = input["credit_card_expiration_date"]
    @result = input["result"]
    @created_at = Time.parse(input["created_at"])
    @updated_at = Time.parse(input["updated_at"])
  end

  def self.store(transactions)
    @transactions = transactions
  end

  def to_s
    "#{@id} #{@invoice_id} #{@credit_card_number} #{@credit_card_expiration_date} #{@result} #{@created_at} #{@updated_at}"
  end

  def self.all
    @transactions
  end
end
