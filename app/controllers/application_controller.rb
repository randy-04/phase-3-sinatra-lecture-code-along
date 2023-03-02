class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/hackathon" do
    hackathons = Hackathon.all
    hackathons.to_json
  end

  # get single hackathon
  get "/hackathon/:pk" do
    hackathon = Hackathon.find_by(id: params[:pk])
  end

  post "/hackathon" do
    hack = Hackathon.create(
      image_url: params[:image_url],
      topic: params[:topic],
      description: params[:description],
      location: params[:location],
      datetime: params[:datetime]
  )

  hack.save

  {
    "message": "Success",
    "Status": "200 G"
  }.to_json

  end

  patch "/hackathon/update/:id" do
    hack = Hackathon.find_by(id: params[:id])

    hack.update(
      image_url: params[:image_url],
      topic: params[:topic],
      description: params[:description],
      location: params[:location],
      datetime: params[:datetime]
    )

    hack.to_json
  end

  delete "/hackathon/:id" do
    hack = Hackathon.find_by(id: params[:id])
    hack.destroy

    {
      "message": "Deleted Hackathon #{params[:id]}",
      "Status": "request OK"
    }.to_json()
  end

  post '/user' do
    existing_user = User.find_by(email: params[:email])
    # check if user exists
    if existing_user
      return {"error": "User exists!"}.to_json

    end

    # create user instance
    user = User.create(
      fullname: params[:fullname],
      email: params[:topic],
      phonenumber: params[:phonenumber],
      language: params[:language],
      roles: params[:roles]
    )

    user.save

    {
      "message": "user created successfully",
      "status": "201_success"
    }.to_json
  end

  # get all hackathon users
  get '/hackathon/:id/users' do
    hackathon = Hackathon.find_by(id: params[:id])
    hackathon.events.find_all do |event| 
      event.user_id
    end.to_json(only: [:id], include: {user: {only: [:id, :fullname, :email, :phonenumber, :language, :roles]}})
  end

end
