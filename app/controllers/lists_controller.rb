class ListsController < ApplicationController
    get '/lists' do
        redirect '/login' unless logged_in?
        @user = current_user
        erb :'lists/homepage'
    end

    get '/lists/new' do
        redirect '/login' unless logged_in?
        erb :'lists/new'
    end

    post '/lists' do #make this less complicated
        if params[:list][:list_title].empty? || params[:list][:list_item].empty?
            flash[:message] = "Please fill out all the fields available."
            redirect '/lists/new'
        else
            user = current_user
            user.lists.create(params[:list])
            user.save
            redirect '/lists'
        end
    end

    get '/lists/:id' do
        @list = List.find_by_id(params[:id])
        erb :'lists/show'
    end

    get '/lists/:id/edit' do
        @list = List.find_by_id(params[:id])
        erb :'lists/edit'
    end

    patch '/lists/:id' do
        
        redirect '/login' unless logged_in?
        list = List.find_by_id(params[:id])
        if list.user == current_user
            list.update(params[:list])
            list.save
            redirect "/lists/#{list.id}"
        else
            redirect "/lists/#{list.id}"
        end
    end

    delete '/lists/:id/delete' do 
        redirect '/login' unless logged_in?
        list = List.find_by_id(params[:id])
        if list.user == current_user
            flash[:message] = "Your list #{list.list_title} has been deleted"
            list.delete
            redirect '/lists'
        else
            redirect '/lists'
        end
    end
end