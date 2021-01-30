FactoryBot.define do
  factory :label do
    name { "ラベル1" }
  end
  factory :label_second, class: Label do
    name { "ラベル2" }
  end
  factory :label_third, class: Label do
    name { "ラベル3" }
  end
end
