class GitCommitsController < ApplicationController
  before_action :require_current_git_commit, :only => [:show]
  before_action :require_current_user, :only => [:new, :create]
  before_action :require_repo_if_repo_external_id_passed, :only => [:create]

  def new
    @git_commit = GitCommit.new
    @repos = current_user.repos.all
  end

  def create
    @git_commit = current_user.git_commits.create(git_commit_params)

    respond_to do |format|
      if @git_commit.valid?
        format.html do
          redirect_to git_commit_path(@git_commit)
        end
        format.json do
          render :json => @git_commit
        end
      else
        format.html do
          render :new, :status => :unprocessable_entity
        end
        format.json do
          render :json => {:errors => @git_commit.errors.as_json }, :status => :unprocessable_entity
        end
      end
    end
  end

  def show
  end

  def index
    if params[:shas].blank?
      return head :bad_request
    end

    commits = GitCommit.where(:sha => params[:shas].split(','))
    render :json => commits
  end

  def latest_commits
    limit = params[:limit] ||= 5

    commits = GitCommit
    commits = commits.where(:user_id => params[:user_ids]) if params[:user_ids]
    commits = commits.order("created_at DESC").limit(limit)
    render :json => commits
  end

  private
  helper_method :current_git_commit
  def current_git_commit
    @git_commit ||= GitCommit.find_by_id(params[:id])
  end

  def require_current_git_commit
    head :not_found unless current_git_commit
  end

  def require_repo_if_repo_external_id_passed
    if params[:git_commit] && params[:git_commit][:repo_external_id]
      external_id = params[:git_commit][:repo_external_id]
      repo = Repo.find_by_external_id(external_id)
      head :not_found unless repo
    end
  end

  def git_commit_params
    params.require(:git_commit).permit(:sha, :repo_external_id, :image, :raw)
  end
end
