%w[sinatra dm-core dm-migrations slim sass].each{ |lib| require lib }

DataMapper.setup(:default, ENV['DATABASE_URL'] || File.join("sqlite://",settings.root,"dev.db"))


class Doll
	include DataMapper::Resource

	property :id, Serial
	property :head, Integer, :default => proc { |m,p| 1+rand(6) }
	property :body, Integer, :default => proc { |m,p| 1+rand(3) }
	property :legs, Integer, :default => proc { |m,p| 1+rand(3) }

end
DataMapper.finalize

### Routes for our awesome app ###


get '/stylesheets/:name.css' do
	content_type 'text/css', :charset => 'utf-8'
	scss(:"#{params[:name]}")
end


get '/' do 
	@dolls = Doll.all
	slim :index
	
end


post '/create/doll' do
	doll = Doll.create
	
	if request.xhr?
		slim :doll, { :layout => false, :locals => { :doll => doll } }
	else
		redirect to('/')
	end
end

delete '/delete/doll/:id' do
	Doll.get(params[:id]).destroy
	redirect to('/') unless request.xhr?
end


