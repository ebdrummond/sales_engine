require 'csv'
require 'time'

class Invoice

  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

  def initialize(input)
    @id = input["id"]
    @customer_id = input["customer_id"]
    @merchant_id = input["merchant_id"]
    @status = input["status"]
    @created_at = Time.parse(input["created_at"])
    @updated_at = Time.parse(input["updated_at"])
  end

  def to_s
    "#{@id} #{@customer_id} #{@merchant_id} #{@status} #{@created_at} #{@updated_at}"
  end

  def self.store(invoices)
    @invoices = invoices
  end

  def self.all
    @invoices
  end
end


