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
    collection.find{|merchant| merchant.name.downcase == name.downcase}
  end

  def self.find_by_created_at(created_at)
    collection.find{|merchant| merchant.created_at.downcase == created_at.downcase}
  end

  def self.find_by_updated_at(updated_at)
    collection.find{|merchant| merchant.updated_at.downcase == updated_at.downcase}
  end

  def self.find_all_by_id(id)
    collection.select{|merchant| merchant.id == id}
  end

  def self.find_all_by_name(name)
    collection.select{|merchant| merchant.name.downcase == name.downcase}
  end

  def self.find_all_by_created_at(created_at)
    collection.select{|merchant| merchant.created_at.downcase == created_at.downcase}
  end

  def self.find_all_by_updated_at(updated_at)
    collection.select{|merchant| merchant.updated_at.downcase == updated_at.downcase}
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

  def revenue(date = :all)
    if date == :all
      grand_total = 0
      invoices.each do |invoice|
        if invoice.paid?
          grand_total = grand_total + invoice.total
         end
       end
    grand_total
    else  
      grand_total = 0
      invoices.each do |invoice|
        if invoice.paid? && invoice.created_at.include?(date)
          grand_total = grand_total + invoice.total
        end
      end
    end
    grand_total
  end

  def self.revenue(date)
    revenue_for_date = collection.collect{|merchant| merchant.revenue(date)}
    revenue_for_date.inject(0){|sum, revenue| sum + revenue}
  end

  def self.most_revenue(number)
    highest_earners = collection.sort_by{|merchant| merchant.revenue}
    highest_earners.reverse[0..number-1]
  end

  def item_count
    grand_total = 0
    invoices.each do |invoice|
      if invoice.paid?
        invoice.invoice_items.each do |invoice_item|
        grand_total = invoice_item.quantity + grand_total
        end
      end
    end
    grand_total
  end

  def self.most_items(number)
    highest_sellers = collection.sort_by{|merchant| merchant.item_count}
    highest_sellers.reverse[0..number-1]
  end

  def pending_invoices
    invoices.reject{|invoice| invoice.paid?}
  end

  def customers_with_pending_invoices
    pending_invoices.inject([]) do |customers, invoice| 
      customers << invoice.customer
    end
  end

  def customers_per_merchant
    customer_hash = Hash.new(0)
    invoices.each do |invoice|
      if invoice.paid?
        customer_hash[invoice.customer_id] += 1
      end
    end
    customer_hash
  end

  def sorted_customers_per_merchant
    sorted_list = customers_per_merchant.sort_by{|customer_id, purchases| purchases }.reverse
    sorted_list.first[0]
  end

  def favorite_customer
    result = sorted_customers_per_merchant
    Customer.find_by_id(result)
  end
end
