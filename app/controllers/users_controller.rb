class UsersController < Sinatra::Base
    get '/signup' do
        erb :'users/signup'
    end

    post '/signup' do
        @user = User.new(params)
        if @user.save
            @lists = User.lists.all
            session[:user_id] = user.id 
            erb :homepage 
        else
            flash[:message] = "Please fill out all the fields"
            redirect '/signup'
        end
    end

    get '/login' do
        erb :'users/login'
    end

    post '/login' do
        @user = User.find_by_id(params[:id])
        if @user && @user.authenticate(params[:password])
            @lists = User.lists.all
            erb :homepage
        else 
            flash[:message] = "Please fill out all the fields"
            redirect '/login'
        end
    end
end