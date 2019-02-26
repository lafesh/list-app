require 'pry'

class ListsController < ApplicationController
    get '/lists' do
        redirect '/login' unless logged_in?
        @user = current_user
        erb :'lists/index'
    end
    
    get '/lists/new' do
        redirect '/login' unless logged_in?
        erb :'lists/new'
    end

    post '/lists' do
        if params[:list][:list_title].empty? || params[:list][:list_items].empty?
            flash[:message] = "Please fill out all the fields available."
            redirect '/lists/new'
        else
            user = current_user
            list = user.lists.create(list_title: params[:list][:list_title])
            params[:list][:list_items].each do |item|
                list.list_items.create(item)
            end   
            list.list_items.each {|i| i.created_at = list.created_at}
            redirect "/lists/#{list.id}"
        end
    end

    get '/lists/all' do
        redirect '/login' unless logged_in?
        @lists = List.all     
        erb :'lists/all'
    end 
    
    post '/lists/search' do
        binding.pry
        @lists = List.all.select {|list| list.user.first_name.include?(params[:query])}
        
        erb :'lists/all'
    end

    get '/lists/:id' do
        redirect '/login' unless logged_in?
        @list = List.find_by_id(params[:id])
        
        erb :'lists/show'
    end

    get '/lists/:id/edit' do
        redirect '/login' unless logged_in?
        @list = List.find_by_id(params[:id])
        erb :'lists/edit'
    end

    patch '/lists/:id' do 
        redirect '/login' unless logged_in?
        list = List.find_by_id(params[:id])
        if list.user == current_user
            list.update(list_title: params[:list][:list_title])
            list.save

            if list.list_items.length < params[:list][:list_items].length
                params[:list][:list_items][list.list_items.length..params[:list][:list_items].length].each do |item|
                    list.list_items.create(item)
                end
            end

            params[:list][:list_items].each_with_index do |item, i|
                list.list_items[i].update(item)
            end   
            redirect "/lists/#{list.id}"
        else
            flash[:message] = "You need to be the Creator of this List to edit it"
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
            flash[:message] = "You need to be the Creator of this List to delete it"
            redirect '/lists'
        end
    end
end