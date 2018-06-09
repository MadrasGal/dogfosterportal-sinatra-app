class DogsController < ApplicationController

  # Display details of all dogs 
  get '/dogs' do
    if session[:user_id]
      binding.pry
      @dog= Dog.all 
      erb :'dogs/dogs'
    else 
      #to add flash message
      redirect '/login'
    end
  end 

  # Create Dog / Add new dog to db

  get '/dogs/new' do 
    if session[:id]
      erb :'dogs/create_dog'
    else 
      # to add flash message 
      redirect '/login'
    end 
  end 

  # Display dog by id 

  get '/dogs/:id' do 
    if session[:id]
      @dog= Tweet.find(params[:id])
      erb :'/dogs/show_dog'
    else
      # to add flash message
      redirect "/login"
    end
  end


  # Edit/Update Dog details 

  get '/dogs/:id/edit' do
    if session[:id]
      @dog= Dog.find(params[:id])
      @user=User.find_by(session[:id]) 
         
      erb :'/dogs/edit_dog'
    else
      # to add flash message 
      redirect "/login"
    end
  end

  patch '/dogs/:id' do
    if session[:id]
      @dog= Dog.find(params[:id])
      #if params[:content] != ""
      #  @tweet.update(content: params[:content])
      #  redirect "/tweets/#{@tweet.id}"
      #else
      #  redirect "/dogs/#{@dog.id}/edit"
      #end
    else
      #to add flash message
      redirect '/login'
    end
  end

  #Delete dog 

  delete '/dogs/:id/delete' do
    if session[:id]
      
      if Dog.find(params[:id])
        @dog = Dog.find(params[:id])
        @user=User.find_by(session[:id])
        
        if @dog.user_id == @user.id
            @dog.delete
        else
          redirect '/dogs'
        end 
        
      else
        redirect '/dogs'
      end
    
    else
      redirect '/login'
    end
  end  

end 