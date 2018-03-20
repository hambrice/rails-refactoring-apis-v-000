class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    github = GithubService.new
    github.authenticate!(ENV['GITHUB_CLIENT'], ENV['GITHUB_SECRET'], params[:code])
    session["access_token"] = github.access_token
    session[:token] = github.access_token
    #binding.pry
    redirect_to root_path
  end
end
