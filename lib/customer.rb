require 'csv'
require 'time'
require_relative 'invoice'


class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at

  def initialize(input)
    @id = input["id"].to_i
    @first_name = input["first_name"]
    @last_name = input["last_name"]
    @created_at = Time.parse(input["created_at"]).to_s
    @updated_at = Time.parse(input["updated_at"]).to_s
  end

  def to_s
    "#{@id} #{@first_name} #{@last_name} #{@created_at} #{@updated_at}"
  end

  def self.store(customers)
    @customers = customers
 end

  def self.collection
    @customers
  end

  def self.find_by_id(id)
    collection.find{|customer| customer.id == id}
  end

  def self.find_by_first_name(first_name)
    collection.find{|customer| customer.first_name.downcase == first_name.downcase}
  end

  def self.find_by_last_name(last_name)
    collection.find{|customer| customer.last_name.downcase == last_name.downcase}
  end

  def self.find_by_created_at(created_at)
    collection.find{|customer| customer.created_at.downcase == created_at.downcase}
  end

  def self.find_by_updated_at(updated_at)
    collection.find{|customer| customer.updated_at.downcase == updated_at.downcase}
  end

  def self.find_all_by_id(id)
    collection.select{|customer| customer.id == id}
  end

  def self.find_all_by_first_name(first_name)
    collection.select{|customer| customer.first_name.downcase == first_name.downcase}
  end

  def self.find_all_by_last_name(last_name)
    collection.select{|customer| customer.last_name.downcase == last_name.downcase}
  end

  def self.find_all_by_created_at(created_at)
    collection.select{|customer| customer.created_at.downcase == created_at.downcase}
  end

  def self.find_all_by_updated_at(updated_at)
    collection.select{|customer| customer.updated_at.downcase == updated_at.downcase}
  end

  def self.random
    collection.sample
  end

  def invoices
    Invoice.find_all_by_customer_id(id)
  end

  def merchants_per_customer
    merchant_hash = Hash.new(0)
    invoices.each do |invoice|
      if invoice.paid?
        merchant_hash[invoice.merchant_id] += 1
      end
    end
    merchant_hash
  end

  def sorted_merchants_per_customer
    sorted_list = merchants_per_customer.sort_by{|merchant_id, purchases| purchases }.reverse
    sorted_list.first[0]
  end

  def favorite_merchant
    result = sorted_merchants_per_customer
    Merchant.find_by_id(result)
  end

  def transactions
    valid_transactions = []
    invoices.each do |invoice|
      if invoice.paid?
        valid_transactions << (invoice.transactions)
      end
    end
    valid_transactions
  end
end
