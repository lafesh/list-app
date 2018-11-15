class UsersController < ApplicationController
    get '/lists' do
        erb :'lists/homepage'
    end
end