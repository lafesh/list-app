class UsersController < ApplicationController
    get '/signup' do
        erb :'users/signup'
    end

    post '/signup' do
        @user = User.new(params)
        if @user.save
            session[:user_id] = @user.id 
            redirect '/lists'
        else
            flash[:message] = "Please fill out all the fields"
            redirect '/signup'
        end
    end

    get '/login' do
        erb :'users/login' unless logged_in?
        redirect '/lists'
    end

    post '/login' do
        user = User.find_by_id(params[:id])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/lists'
        else 
            flash[:message] = "Please fill out all the fields"
            redirect '/login'
        end
    end

    get '/logout' do
        #should i make sure that its the user with the same session id?
        session.clear 
        flash[:message] = "Thank you for visiting My Lists. Have a wonderful day!"
        redirect '/'     
    end
end