require 'rails_helper'

describe User do
  describe '正常の状態' do
    describe '一般ユーザ' do
      let(:user) { create(:user_normal)}
      it '一通りのフィールドが設定されている' do
        expect(user).to be_valid
      end
    end
    describe '管理者' do
      let(:user) { create(:user_admin)}
      it '一通りのフィールドが設定されている' do
        expect(user).to be_valid
      end
    end
  end

  describe 'バリデーションチェック' do
    describe 'メールアドレス未設定' do
      it 'バリデーションエラーになる' do
        is_expected.to validate_presence_of(:email)
      end
    end
    describe '名前未設定' do
      it 'バリデーションエラーになる' do
        is_expected.to validate_presence_of(:name)
      end
    end
    describe 'パスワード未設定' do
      it 'バリデーションエラーになる' do
        is_expected.to validate_presence_of(:password)
      end
    end
    describe 'パスワード文字数が4文字未満だと、' do
      it 'バリデーションエラーになる' do
        is_expected.to validate_length_of(:password).is_at_least(4)
      end
    end

  end
end