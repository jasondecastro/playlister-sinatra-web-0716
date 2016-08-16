class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    erb :index
  end

  get '/songs' do
    @songs = Song.all
    erb :songs
  end

  get '/genres' do
    @genres = Genre.all
    erb :genres
  end

  get '/artists' do
    @artists = Artist.all
    erb :artists
  end

  get '/songs/new' do
    erb :new_song
  end

  post '/songs/new' do

    if params[:song][:artist_ids] == nil

      @artist = Artist.find_or_create_by(name: params[:song][:artist])

      new_data = {name: params[:song][:name], genre_ids: params[:song][:genre_ids], artist: @artist}
    elsif params[:song][:artist_ids] != nil
      new_data = {name: params[:song][:name], genre_ids: params[:song][:genre_ids], artist: Artist.find(params[:song][:artist_ids])[0]}
    else
      'sorry'
    end


    
    @song = Song.create(new_data)


    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    if params[:slug].length > 3
      @string = params[:slug].gsub("-", " ").gsub(/\w+/, &:capitalize).gsub("With", "with").gsub("The", "the")
      @song = Song.find_by(name: @string)
      @message = "Successfully created song."
      erb :song
    elsif params[:slug].length < 3 && params[:slug].length > 0
      @song = Song.find(params[:slug])
    else
      'sorry'
    end
  end

  get '/songs/:slug/edit' do
    if params[:slug].length > 3
      @string = params[:slug].gsub("-", " ").gsub(/\w+/, &:capitalize).gsub("With", "with").gsub("The", "the")
      @song = Song.find_by(name: @string)
      erb :edit_song
    elsif params[:slug].length < 3 && params[:slug].length > 0
      @song = Song.find(params[:slug])
    else
      'sorry'
    end
  end

  patch '/songs/:slug' do
    new_data = {name: params[:song][:name], genre_ids: params[:song][:genre_ids], artist: Artist.find(params[:song][:artist_ids])[0]}
    @message = "Sucessfully updated song."
    erb :song
  end

  get '/artists/:slug' do
    if params[:slug].length > 3
      @string = params[:slug].gsub("-", " ").gsub(/\w+/, &:capitalize).gsub("With", "with").gsub("The", "the").gsub("A", "a")
      @artist = Artist.find_by(name: @string)
      erb :artist
    elsif params[:slug].length < 3 && params[:slug].length > 0
      @artist = Artist.find(params[:slug])
    else
      'sorry'
    end
  end

  get '/genres/:slug' do
    if params[:slug].length > 3
      @string = params[:slug].gsub("-", " ").gsub(/\w+/, &:capitalize).gsub("With", "with").gsub("The", "the")
      @genre = Genre.find_by(name: @string)
      erb :genre
    elsif params[:slug].length < 3 && params[:slug].length > 0
      @genre = Genre.find(params[:slug])
    else
      'sorry'
    end
  end  
end