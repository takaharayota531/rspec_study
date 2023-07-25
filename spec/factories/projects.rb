FactoryBot.define do
  factory :project do
    sequence(:name){|n| "Project#{n}"}
    description{"TestProject"}
    due_on{1.week.from_now}
    owner
    

    trait :with_notes do
      after(:create){|project|create_list(:note,5,project: project) }
    end

  # 昨日が締切のプロジェクト
    trait :due_yesterday do
      due_on{1.day.ago}
    end
  # 今日が締切のプロジェクト
    trait :due_today do
      due_on{Date.current.in_time_zone}
    end

  # 明日が締切のプロジェクト
    trait :due_tomorrow do
      due_on{Date.current.in_time_zone}
    end

    trait :invalid_name do
      name{nil}
    end
end
end