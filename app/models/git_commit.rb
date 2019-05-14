class GitCommit < ApplicationRecord
  validates :sha, :repo_id, presence: true

  mount_uploader :image, ImageUploader

  belongs_to :user
  belongs_to :repo
  self.per_page = 10

  def repo_external_id=(external_id)
    repo = Repo.find_by_external_id(external_id)
    self.repo = repo

    if ! repo.blank? && ! user.blank? && !repo.users.include?(user)
      repo.users << self.user
    end
  end

  def repo_external_id
    repo ? repo.external_id : nil
  end
end
