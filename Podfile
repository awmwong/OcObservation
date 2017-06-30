use_frameworks!
inhibit_all_warnings!
platform :ios, '10.0'

target 'rxobjc' do
    pod 'RxSwift',    '~> 3.0'
    pod 'RxCocoa',    '~> 3.0'
end

# RxTests and RxBlocking make the most sense in the context of unit/integration tests
target 'rxobjcTests' do
    pod 'RxBlocking', '~> 3.0'
    pod 'RxTest',     '~> 3.0'
end
