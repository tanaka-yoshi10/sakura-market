require 'rails_helper'

describe Address do
  let!(:user) { create(:user_normal)}

  describe '正常の状態' do
    let(:address) { create(:address, user: user)}
    it '一通りのフィールドが設定されている' do
      expect(address).to be_valid
    end
  end

  describe 'バリデーションエラー' do
    describe '郵便番号未設定' do
      let(:address) { create(:address, user: user, zip_code: '')}
      it 'バリデーションエラーになる' do
        is_expected.to validate_presence_of(:zip_code)
                           .with_message("を入力してください")
      end
    end
    describe '都道府県未設定' do
      let(:address) { create(:address, user: user, prefectures: '')}
      it 'バリデーションエラーになる' do
        is_expected.to validate_presence_of(:prefectures)
                           .with_message("を入力してください")
      end
    end
    describe '市区町村未設定' do
      let(:address) { create(:address, user: user, city: '')}
      it 'バリデーションエラーになる' do
        is_expected.to validate_presence_of(:city)
                           .with_message("を入力してください")
      end
    end
    describe '町名番地未設定' do
      let(:address) { create(:address, user: user, address: '')}
      it 'バリデーションエラーになる' do
        is_expected.to validate_presence_of(:address)
                           .with_message("を入力してください")
      end
    end
    describe '町名番地2未設定' do
      let(:address) { create(:address, user: user, address2: '')}
      it '正常になる' do
        expect(address).to be_valid
      end
    end
  end
end