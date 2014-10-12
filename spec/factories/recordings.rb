FactoryGirl.define do
  factory :recording do
    factory :response_recording do
      association :recordable, factory: :response
    end
    url "http://images.amplified.com/FLVStream/Catalog/141734a5-4d3f-46fe-86cc-edb7c07346c4/Product/de84a480-0e12-4489-9188-37f03127d653/094637004357_01_003_wm9_128k_30sec_0001_102.mp3"
  end
end
