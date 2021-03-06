class ReposController < ApplicationController
  before_action :require_current_user, :except => [:show, :index]
  before_action :require_current_repo, :only => [:show, :destroy]

  def new
    @repo = Repo.new
  end

  def create
    @repo = Repo.new(repo_params || Hash.new)
    if @repo.valid?
      @repo.users << current_user
      @repo.save
      redirect_to repo_path(@repo)
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def show
    respond_to do |format|
        format.json { render json: current_repo }
        format.html {
          @git_commits = current_repo.git_commits.order("id DESC").paginate(:page => params[:page] || 1)
        }
    end
  end

  def index
    if params[:repos]
      @repos = Repo.where(:name => params[:repos])
    else
      @repos = Repo.all
    end

    respond_to do |format|
      format.json { render json: @repos}
    end
  end

  def destroy
    # ensure all git commits are destroyed first
    current_repo.git_commits.destroy_all

    if !current_repo.git_commits.exists?
      current_repo.destroy
      redirect_to root_url
    else
      redirect_to repo_path(current_repo)
    end
  end

  private
  helper_method :current_repo
  def current_repo
    @current_repo ||= Repo.find_by_id(params[:id])
  end

  def require_current_repo
    head :not_found unless current_repo
  end

  def repo_params
    params.require(:repo).permit(:name)
  end
end
