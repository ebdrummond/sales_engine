require 'csv'
require 'time'
require 'bigdecimal'
require_relative 'item'

class Merchant
  attr_reader :id, :name, :created_at, :updated_at


  def initialize(input)
    @id = input["id"].to_i
    @name = input["name"]
    @created_at = Time.parse(input["created_at"]).to_s
    @updated_at = Time.parse(input["updated_at"]).to_s
  end

  def to_s
    "#{@id} #{@name} #{@created_at} #{@updated_at}"
  end

  def self.store(merchants)
    @merchants = merchants
  end

  def self.collection
    @merchants
  end

  def self.find_by_id(id)
    collection.find{|merchant| merchant.id == id}
  end

  def self.find_by_name(name)
    collection.find{|merchant| merchant.name == name}
  end

  def self.find_by_created_at(created_at)
    collection.find{|merchant| merchant.created_at == created_at}
  end

  def self.find_by_updated_at(updated_at)
    collection.find{|merchant| merchant.updated_at == updated_at}
  end

  def self.find_all_by_id(id)
    collection.select{|merchant| merchant.id == id}
  end

  def self.find_all_by_name(name)
    collection.select{|merchant| merchant.name == name}
  end

  def self.find_all_by_created_at(created_at)
    collection.select{|merchant| merchant.created_at == created_at}
  end

  def self.find_all_by_updated_at(updated_at)
    collection.select{|merchant| merchant.updated_at == updated_at}
  end

  def self.random
    collection.sample
  end

  def items
    Item.find_all_by_merchant_id(id)
  end

  def invoices
    Invoice.find_all_by_merchant_id(id)
  end

  def revenue
    grand_total = 0
    invoices.each do |invoice|
      if invoice.valid_transaction.count > 0
        invoice.invoice_items.each do |invoice_item|
          grand_total = invoice_item.quantity * invoice_item.unit_price + grand_total
        end
      end
    end
    grand_total
    # puts BigDecimal.new(grand_total.to_s)
  end

  def self.most_revenue(number)
    highest_earners = collection.sort_by{|merchant| merchant.revenue}
    highest_earners[0..number-1]
  end


  # def self.most_revenue(number)
  #   successful_transactions = Transaction.find_all_by_result("success")
  #   successful_invoices = []
  #   successful_transactions.each do |transaction|
  #     successful_invoices<< transaction.invoice
  #   end

  #   invoice_items_list = []
  #   successful_invoices.each do |invoice|
  #     invoice_items_list<< invoice.invoice_items
  #   end

  # end
end


