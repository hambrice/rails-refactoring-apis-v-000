class RepositoriesController < ApplicationController
  def index
    session[:service] ? hash = session[:service] : hash = session
    github = GithubService.new(hash)
    @username = github.get_username
    @repos = github.get_repos
  end

  def create
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end
end
