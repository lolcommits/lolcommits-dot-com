class CustomDomainRedirect
  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    if req.host != ENV['CUSTOM_DOMAIN']
      [301, {'Location' => "#{req.scheme}://#{ENV['CUSTOM_DOMAIN']}", 'Content-Type' => 'text/html'}, ['Moved Permanently']]
    else
      @app.call(env)
    end
  end
end
