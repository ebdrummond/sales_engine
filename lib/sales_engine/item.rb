module SalesEngine
  class Item
    attr_reader :id, :name, :description, :unit_price,
                      :merchant_id, :created_at, :updated_at

    def initialize(input)
      @id = input["id"].to_i
      @name = input["name"]
      @description = input["description"]
      @unit_price = BigDecimal.new(input["unit_price"].to_i / 100.0, 12)
      @merchant_id = input["merchant_id"].to_i
      @created_at = Date.parse(input["created_at"])
      @updated_at = Date.parse(input["updated_at"])
    end

    def to_s
      [@id, @name, @description, @unit_price,
        @merchant_id, @created_at, @updated_at
        ].join(" ")
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
      collection.find{|item| item.name.downcase == name.downcase}
    end

    def self.find_by_description(description)
      collection.find{|item| item.description.downcase == description.downcase}
    end

    def self.find_by_unit_price(unit_price)
      collection.find{|item| item.unit_price == BigDecimal.new(unit_price)}
    end

    def self.find_by_merchant_id(merchant_id)
      collection.find{|item| item.merchant_id == merchant_id}
    end

    def self.find_by_created_at(created_at)
      collection.find{|item| item.created_at == created_at}
    end

    def self.find_by_updated_at(updated_at)
      collection.find{|item| item.updated_at== updated_at}
    end

    # ***************************** Find All By *****************************

    def self.find_all_by_id(id)
      collection.select{|item| item.id == id}
    end

    def self.find_all_by_name(name)
      collection.select{|item| item.name.downcase == name.downcase}
    end

    def self.find_all_by_description(description)
      collection.select do |item|
        item.description.downcase == description.downcase
      end
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

    def merchant
      Merchant.find_by_id(merchant_id)
    end

    def invoice_items
      InvoiceItem.find_all_by_item_id(id)
    end

    def invoices
      @invoices ||= invoice_items.collect do |invoice_item|
        invoice_item.invoice.uniq
      end
    end

    def paid_invoices
      @paid_invoices ||= invoices.select{|invoice| invoice.paid? }
    end

    def revenue
       paid_invoice_items = invoice_items.select{|ii| ii.invoice.paid? }
       paid_invoice_items.collect{|ii| ii.subtotal}.inject(:+) || 0
    end

    def self.most_revenue(number)
      collection.sort_by{|item| item.revenue}.reverse.take(number)
    end

    def total_sold
      total = 0
      invoice_items.each do |invoice_item|
        if invoice_item.invoice.paid?
          total += invoice_item.quantity
        end
      end
      return total
    end

    def self.most_items(number)
      highest_sellers = collection.sort_by{|item| item.total_sold}
      highest_sellers.reverse[0,number]
    end

    def items_sold_per_day
      i_per_day = Hash.new(0)
      invoice_items.each do |invoice_item|
        i_per_day[invoice_item.invoice.invoice_date] += invoice_item.quantity
      end
      i_per_day
    end

    def best_day
      day = items_sold_per_day.max_by{|invoice_date, quantity| quantity}[0]
      Date.parse(day)
    end
  end
end
