# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいく時' do
      it 'nickname, name, name_kana, age, phone_number, email, password, password_confirmationが存在すれば有効' do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかない時' do
      it 'nicknameが空' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end
      it 'nicknameが41文字以上' do
        @user.nickname = 'afhlajfkldjfkdjflkjalfjdljsaflk;jfsdkj!jfdjfaj;afj'
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームは40文字以内で入力してください')
      end
      it 'nameが空' do
        @user.name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前を入力してください')
      end
      it 'nameが英語を含む' do
        @user.name = 'Yamada太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前は不正な値です')
      end
      it 'nameが数字を含む' do
        @user.name = 123_456
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前は不正な値です')
      end
      it 'name_kanaが空' do
        @user.name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（カナ）を入力してください')
      end
      it 'name_kanaがカタカナ以外を含む' do
        @user.name_kana = 'Yamadaたろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（カナ）は不正な値です')
      end
      it 'ageが空' do
        @user.age = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('年齢を入力してください')
      end
      it 'ageが全角数字' do
        @user.age = '２５'
        @user.valid?
        expect(@user.errors.full_messages).to include('年齢は数値で入力してください')
      end
      it 'ageが19際未満' do
        @user.age = Faker::Number.between(from: 1, to: 19)
        @user.valid?
        expect(@user.errors.full_messages).to include('年齢は20以上の値にしてください')
      end
      it 'phone_numberが空' do
        @user.phone_number = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('電話番号を入力してください')
      end
      it 'phone_numberが9桁未満' do
        @user.phone_number = Faker::Number.number(digits: 8)
        @user.valid?
        expect(@user.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'phone_numberが12桁以上' do
        @user.phone_number = Faker::Number.number(digits: 12)
        @user.valid?
        expect(@user.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'phone_numberに-が入っている' do
        @user.phone_number = '333-333-3333'
        @user.valid?
        expect(@user.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'passwordが空' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end
      it 'passwordが全部英語' do
        @user.password = 'aaaaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordが全部数字' do
        @user.password = '11111111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordに全角文字が含まれている' do
        @user.password = 'ああああああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordが5文字以下' do
        @user.password = '1111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordとpassword_confirmationが一致しない' do
        @user.password = '11111aaaaaaa'
        @user.password_confirmation = 'aaaaa11111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
      it 'emailが重複する' do
        @user.save
        antother_user = FactoryBot.build(:user)
        antother_user.email = @user.email
        antother_user.valid?
        expect(antother_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailに@がない' do
        @user.email = 'aaaaaa.gmil.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
    end
  end
end
