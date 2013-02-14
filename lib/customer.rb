require 'csv'
require 'time'
# require 'lib/load_files'


class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at

  def initialize(input)
    @id = input["id"]
    @first_name = input["first_name"]
    @last_name = input["last_name"]
    @created_at = Time.parse(input["created_at"])
    @updated_at = Time.parse(input["updated_at"])
  end

  def to_s
    "#{@id} #{@first_name} #{@last_name} #{@created_at} #{@updated_at}"
  end

  def self.store(customers)
    @customers = customers
 end

  def self.all
    @customers
  end

end