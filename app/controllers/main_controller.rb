class MainController < ApplicationController

  def index
    if current_user
      @git_commits = current_user.git_commits.order(created_at: :desc).limit(5)
    end
  end
end
