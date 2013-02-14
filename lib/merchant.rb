require 'csv'
require 'time'
# require 'lib/load_files'

class Merchant
  attr_reader :id, :name, :created_at, :updated_at


  def initialize(input)
    @id = input["id"]
    @name = input["name"]
    @created_at = Time.parse(input["created_at"])
    @updated_at = Time.parse(input["updated_at"])
  end

  def to_s
    "#{@id} #{@name} #{@created_at} #{@updated_at}"
  end

  def self.store(merchants)
    @merchants = merchants
  end

  def self.all
    @merchants
  end

end
