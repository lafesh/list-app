class UsersController < Sinatra::Base
    get '/signup' do
        erb :'users/signup'
    end

    post '/signup' do
        @user = User.new(params)
        if @user.save
            session[:user_id] = user.id 
            erb :homepage 
        else
            flash[:message] = "Please fill out all the fields"
            redirect '/signup'
        end
    end
end