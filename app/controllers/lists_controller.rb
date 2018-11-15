class UsersController < ApplicationController
    get '/lists' do
        erb :'lists/homepage'
    end

    get '/lists/new' do
        redirect '/login' unless logged_in?
        erb :'lists/new'
    end

    post '/lists' do
        list = List.new(params)
        if list.save
            redirect '/lists'
        else 
            flash[:message] = "Please fill out all the fields available."
            redirect '/lists/new'
        end
    end
end