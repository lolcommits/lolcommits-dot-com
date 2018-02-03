class CustomDomainRedirect
  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    if should_redirect?(req)
      [301, {'Location' => "#{req.scheme}://#{ENV['CUSTOM_DOMAIN']}", 'Content-Type' => 'text/html'}, ['Moved Permanently']]
    else
      @app.call(env)
    end
  end

  # dont redirect for legacy plugin code referring to old domain for uploads
  def should_redirect?(req)
    (req.host != ENV['CUSTOM_DOMAIN']) &&
      !((req.path == '/git_commits.json') && req.post?)
  end
end
