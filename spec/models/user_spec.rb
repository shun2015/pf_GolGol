require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? } 

    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        user.name = Faker::Lorem.characters(number: 2)
        expect(user.name.length >= 2).to eq true
      end
      it '20文字以下であること: 20文字は〇' do
        user.name = Faker::Lorem.characters(number: 20)
        expect(user.name.length <= 20).to eq true
      end
      it '20文字以下であること: 21文字は×' do
        user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
    context 'age' do
      it '未選択でないこと' do
        user.age = ''
        is_expected.to eq false
      end
    end
    context 'score' do
      it '未選択でないこと' do
        user.profile_score = ''
        is_expected.to eq false
      end
    end
    context 'introduction' do
      it '150文字以内は◯' do
        user.introduction = Faker::Lorem.characters(number: 150)
        expect(user.introduction.length <= 150).to eq true
      end
      it '150文字以上は×' do
        user.introduction = Faker::Lorem.characters(number: 151)
        is_expected.to eq false
      end
    end
  end
end