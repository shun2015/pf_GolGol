require 'rails_helper'

RSpec.describe Post, type: :model do
 describe 'バリデーションのテスト' do
    subject { post.valid? } 

    let(:post) { build(:post) }

    context 'titleカラム' do
      it '空欄は×' do
        post.title = Faker::Lorem.characters(number: 0)
        is_expected.to eq false
      end
      it '1文字以上は◯' do
        post.title = Faker::Lorem.characters(number: 1)
        expect(post.title.length >= 1).to eq true
      end
      it '50文字以内は◯' do
        post.title = Faker::Lorem.characters(number: 50)
        expect(post.title.length >= 50).to eq true
      end
      it '51文字以上は×' do
        post.title = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end
    context "impressionカラム" do
      it '空欄は×' do
        post.impression = Faker::Lorem.characters(number: 0)
        expect(post.impression.length >= 1).to eq false
      end
      it '1文字以上は◯' do
        post.impression = Faker::Lorem.characters(number: 1)
        expect(post.impression.length >= 1).to eq true
      end
      it '300文字以内は○' do
        post.impression = Faker::Lorem.characters(number: 300)
        expect(post.impression.length <= 300).to eq true
      end
      it '301文字以上は×' do
        post.impression = Faker::Lorem.characters(number: 301)
        expect(post.impression.length <= 300).to eq false
      end
    end
  end
end
