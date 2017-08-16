Rails.application.routes.draw do
    # welcome page
    get '/' => 'welcome#index'

    # api documentations
    get 'APIs' => 'docs#index'
    get 'APIs/example' => 'docs#example'

    # services
    get 'services/test' => 'services#test'

    # users
    post 'users/create' => 'users#create'
    get 'users/show' => 'users#show'
    get 'users/test' => 'users#test'

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
