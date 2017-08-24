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
    post 'users/login' => 'users#login'
    get 'users/show' => 'users#show'
    get 'users/check' => 'users#check'
    get 'users/test' => 'users#test'
    delete 'users/destroy' => 'users#destroy'


    # user contacts
    get 'userContacts/show' => 'user_contacts#show'
    get 'userContacts/check' => 'user_contacts#check'
    delete 'userContacts/destroy' => 'user_contacts#destroy'
    post 'userContacts/create' => 'user_contacts#create'

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
