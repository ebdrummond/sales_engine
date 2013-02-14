require 'csv'
require 'time'
# require 'lib/load_files'


class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

  def initialize(input)
    @id = input["id"]
    @name = input["name"]
    @description = input["description"]
    @unit_price = input["unit_price"]
    @merchant_id = input["merchant_id"]
    @created_at = Time.parse(input["created_at"])
    @updated_at = Time.parse(input["updated_at"])
  end

  def to_s
    "#{@id} #{@name} #{@description} #{@unit_price} #{@merchant_id} #{@created_at} #{@updated_at}"
  end

  def self.store(items)
    @items = items
  end

  def self.all
    @items
  end

end