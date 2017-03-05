class Order < ApplicationRecord
  extend Enumerize

  PAYMENT_TYPE = { cod: 1, credit: 2 }
  enumerize :payment_type, in: PAYMENT_TYPE, default: :cod, scope: true

  STATUSES = { on_cart: 0, ordered: 1}
  enumerize :status, in: STATUSES, default: :on_cart, scope: true

  has_many :order_items, dependent: :destroy
  belongs_to :ship_time
  belongs_to :user

  accepts_nested_attributes_for :order_items

  before_save :finalize

  validates :user, presence: true
  with_options unless: :is_on_cart do
    validates :ship_address, presence: true
    validates :ship_zip_code, presence: true, format: {with: /\d{3}[-]\d{4}|\d{3}[-]\d{2}|\d{3}|\d{5}|\d{7}/}
    validates :order_items, presence: true
  end

  default_value_for :ship_time do
    ShipTime.default_ship_time
  end
  
  def confirm
    self.order_datetime = Time.zone.now
    if self.user.address.present?
      address = self.user.address
      self.ship_zip_code = address.zip_code
      self.ship_address = address.prefectures + address.city + address.address + address.address2
    end
    self.status = :ordered
    self.save
  end

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  def charge_total
    shipping_charge + cod_charge
  end

  def total
    subtotal + charge_total
  end

  def shipping_charge
    shipping_charge = 0
    if order_items.present?
      item_size = order_items.size
      shipping_count = (item_size / 5) + 1
      shipping_charge = shipping_count * 600
    end
    shipping_charge
  end

  def cod_charge
    cod_charge = 0
    if !order_items.present?
      return cod_charge
    end
    if self.payment_type.cod?
      cod_charge = CodCharge.cod_charge_from_amount(subtotal).charge
    end
    cod_charge
  end

  private

  # [review] enumerizeでpredicted: trueを指定するとon_cart?で判定できるようになり、
  # このメソッドは不要にできるかと思います。
  # enumerize :status, in: STATUSES, default: :on_cart, scope: true, predicates: true
  def is_on_cart
    self.status.on_cart?
  end

  def finalize
    self[:subtotal] = subtotal
    self[:cod_charge] = cod_charge
    self[:shipping_charge] = shipping_charge
    self[:total] = total
  end
end
