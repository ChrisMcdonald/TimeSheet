module UserGithubRepos

  def repos(auth)
    repo_list = ['error']
    url = URI.parse("https://api.github.com/user/repos")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new(url.request_uri)
    req["Accept"] = 'application/vnd.github.cloak-preview'
    req["Authorization"] = "token #{auth}" if auth.present?
    res = http.request(req)

    repo_list = JSON.parse(res.body) if res.message == "OK"
    repo_list

  end
end
