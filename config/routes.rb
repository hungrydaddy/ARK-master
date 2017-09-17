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
    delete 'users/destroy' => 'users#destroy'


    # user session
    post 'users/login' => 'users#login'
    get 'users/check' => 'users#check'
    get 'users/all' => 'users#all'


    # user contacts
    get 'userContacts/show' => 'user_contacts#show'
    get 'userContacts/check' => 'user_contacts#check'
    delete 'userContacts/destroy' => 'user_contacts#destroy'
    post 'userContacts/create' => 'user_contacts#create'


    # direct conversations
    get 'direct/show' => 'direct#show'
    post 'direct/create' => 'direct#create'


    # group messaging
    get 'group/show' => 'group#show'
    post 'group/create' => 'group#create'
    post 'group/add' => 'group#add'


    # messages
    get 'message/show' => 'message#show'
    post 'message/create' => 'message#create'



    # locations
    post 'locations/update' => 'locations#update'
    get 'locations/show' => 'locations#show'


    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
