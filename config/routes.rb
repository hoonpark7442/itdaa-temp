Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # classes 말고 다른 클래스명 사용 필요
  post "/itdaa_classes", to: "classes#create"
end
