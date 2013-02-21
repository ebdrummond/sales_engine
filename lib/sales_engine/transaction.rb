module SalesEngine
  class Transaction
    attr_reader :id, :invoice_id, :credit_card_number,
                      :credit_card_expiration_date, :result,
                      :created_at, :updated_at

    def initialize(input)
      @id = input["id"].to_i
      @invoice_id = input["invoice_id"].to_i
      @credit_card_number = input["credit_card_number"]
      @credit_card_expiration_date = input["credit_card_expiration_date"] || ""
      @result = input["result"]
      @created_at = Date.parse(input["created_at"])
      @updated_at = Date.parse(input["updated_at"])
    end

    def self.store(transactions)
      @transactions = transactions
    end

    def to_s
      [@id, @invoice_id, @credit_card_number, @credit_card_expiration_date,
        @result, @created_at, @updated_at
      ].join(" ")
    end

    def self.collection
      @transactions
    end

    # ***************************** Find By *****************************

    def self.find_by_id(id)
      collection.find{|transaction| transaction.id == id}
    end

    def self.find_by_invoice_id(invoice_id)
      collection.find{|transaction| transaction.invoice_id == invoice_id}
    end

    def self.find_by_credit_card_number(credit_card_number)
        collection.find do |transaction|
        transaction.credit_card_number == credit_card_number
      end
    end

    def self.find_by_credit_card_expiration_date(credit_card_expiration_date)
        collection.find do |transaction|
        transaction.credit_card_expiration_date == credit_card_expiration_date
      end
    end

    def self.find_by_result(result)
        collection.find do |transaction|
        transaction.result.downcase == result.downcase
      end
    end

    def self.find_by_created_at(created_at)
      collection.find{|transaction| transaction.created_at == created_at}
    end

    def self.find_by_updated_at(updated_at)
      collection.find{|transactions| transactions.updated_at == updated_at}
    end

    # ***************************** Find All By *****************************

    def self.find_all_by_id(id)
      collection.select{|transaction| transaction.id == id}
    end

    def self.find_all_by_invoice_id(invoice_id)
      collection.select{|transaction| transaction.invoice_id == invoice_id}
    end

    def self.find_all_by_credit_card_number(credit_card_number)
        collection.select do |transaction|
        transaction.credit_card_number == credit_card_number
      end
    end

    def self.find_all_by_credit_card_expiration_date(credit_card_expiration_date)
        collection.select do |transaction|
        transaction.credit_card_expiration_date == credit_card_expiration_date
      end
    end

    def self.find_all_by_result(result)
      collection.select{|transaction| transaction.result == result}
    end

    def self.find_all_by_created_at(created_at)
      collection.select{|transaction| transaction.created_at == created_at}
    end

    def self.find_all_by_updated_at(updated_at)
      collection.select{|transactions| transactions.updated_at == updated_at}
    end

    # ***************************** Random *****************************

    def self.random
      collection.sample
    end

    def invoice
      Invoice.find_by_id(invoice_id)
    end

    def successful?
      result == "success"
    end

    def self.generate_id
      collection.count +1
    end

    def self.create(input)
      transaction = Transaction.new ({
          "id" => generate_id,
          "invoice_id" => input[:invoice_id],
          "credit_card_number" => input[:credit_card_number],
          "credit_card_expiration_date" => input[:credit_card_expiration_date],
          "result" => input[:result],
          "created_at" => Time.now.to_s,
          "updated_at" => Time.now.to_s})
      @transactions << transaction
    end
  end
end
