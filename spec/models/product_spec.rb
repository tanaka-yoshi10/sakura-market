require 'rails_helper'

describe Product do
  describe '正常の状態' do
    it '商品名、単価があるモデルは有効' do
      product = Product.new()
      product.name = '商品その１'
      product.price = 1000
      expect(product).to be_valid
    end
  end


  describe 'バリデーションエラー' do
    it '単価がないモデルは無効' do
      product = Product.new()
      product.name = '商品その１'
      product.valid?
      expect(product.errors[:price]).to include("を入力してください")
    end
    it '商品名がないモデルは無効' do
      product = Product.new()
      product.price = 1000
      product.valid?
      expect(product.errors[:name]).to include("を入力してください")
    end
  end
end