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
        erb :'users/login' 
    end

    post '/login' do
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/lists'
        elsif params[:email].empty? || params[:password].empty?
            flash[:message] = "Please fill out all the fields."
            redirect '/login'
        else 
            flash[:message] = "We could not find you in the database. Please Sign Up."
            redirect '/signup'
        end
    end

    get '/logout' do
        session.clear 
        flash[:message] = "Thank you for visiting My Lists. Have a wonderful day!"
        redirect '/'     
    end
    
    get '/settings' do
        erb :'users/settings'
    end

    get '/close' do
        redirect '/login' unless logged_in?
        User.delete(current_user)
        redirect '/'
    end
end