require 'digest/sha1'

FactoryBot.define do
  factory :git_commit do
    sha { Digest::SHA1.hexdigest(UUID.generate(:compact)) }
    association :user
    association :repo
    image { Rack::Test::UploadedFile.new(Rails.root.join('test/fixtures/f0cbd41f2ac.jpg'), 'image/jpeg') }
  end

  factory :user do
    name { "kenmazaika" }
    sequence(:github_id) { |n| n }
    sequence(:email) {|n| "kenmazaika#{n}@gmail.com" }
    token { UUID.generate(:compact) }
  end

  factory :repo do
    name { UUID.generate(:compact) }
    external_id { UUID.generate(:compact) }
  end
end
