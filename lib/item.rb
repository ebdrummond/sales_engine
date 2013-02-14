require 'csv'
require 'time'
# require 'lib/load_files'


class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

  def initialize(input)
    @id = input["id"].to_i
    @name = input["name"].to_s
    @description = input["description"].to_s
    @unit_price = input["unit_price"].to_i
    @merchant_id = input["merchant_id"].to_i
    @created_at = Time.parse(input["created_at"]).to_s
    @updated_at = Time.parse(input["updated_at"]).to_s
  end

  def to_s
    "#{@id} #{@name} #{@description} #{@unit_price} #{@merchant_id} #{@created_at} #{@updated_at}"
  end

  def self.store(items)
    @items = items
  end

  def self.collection
    @items
  end

  # ***************************** Find By *****************************

  def self.find_by_id(id)
    collection.find{|item| item.id == id}
  end

  def self.find_by_name(name)
    collection.find{|item| item.name == name}
  end

  def self.find_by_description(description)
    collection.find{|item| item.description == description}
  end

  def self.find_by_unit_price(unit_price)
    collection.find{|item| item.unit_price == unit_price}
  end

  def self.find_by_merchant_id(merchant_id)
    collection.find{|item| item.merchant_id == merchant_id}
  end

  def self.find_by_created_at(created_at)
    collection.find{|item| item.created_at == created_at}
  end

  def self.find_by_updated_at(updated_at)
    collection.find{|item| item.updated_at == updated_at}
  end

  # ***************************** Find All By *****************************

 def self.find_all_by_id(id)
    collection.select{|item| item.id == id}
  end

  def self.find_all_by_name(name)
    collection.select{|item| item.name == name}
  end

  def self.find_all_by_description(description)
    collection.select{|item| item.description == description}
  end

  def self.find_all_by_unit_price(unit_price)
    collection.select{|item| item.unit_price == unit_price}
  end

  def self.find_all_by_merchant_id(merchant_id)
    collection.select{|item| item.merchant_id == merchant_id}
  end

  def self.find_all_by_created_at(created_at)
    collection.select{|item| item.created_at == created_at}
  end

  def self.find_all_by_updated_at(updated_at)
    collection.select{|item| item.updated_at == updated_at}
  end  

  # ***************************** Find Random *****************************

  def self.random
    collection.sample
  end

end