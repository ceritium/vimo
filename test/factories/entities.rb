# frozen_string_literal: true

FactoryBot.define do
  factory :entity, class: "Vimo::Entity" do
    sequence :name do |n|
      "name #{n}"
    end
  end
end
