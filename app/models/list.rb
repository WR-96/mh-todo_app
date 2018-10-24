class List < ApplicationRecord
  has_many :items, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  
  def self.to_csv
    attributes = %w(name items_titles)
    headers = %w(list items)
    CSV.generate(headers: true) do |csv|
      csv << headers 
      all.each do |list|
        csv << attributes.map{ |attr| list.send(attr) }
      end
    end
  end

  def items_titles
    titles = []
    self.items.each do |item|
      titles.push(item.title)
    end
    titles.join(', ')
  end

end
