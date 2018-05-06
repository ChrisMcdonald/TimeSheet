class Github

  

  def initialize( options = {})

    # @day = options[:day] if options[:day].present?
    @auth = options[:token] if options[:token].present?

  end

  def commit_on_day(day,gitname,branch,author)
# https://api.github.com/repos/StephenKellyQLD/G2A/commits?,since:2018-04-06%2000:00:00%20+1000,until:2018-04-06T23:59:59+10:00

    date = day.beginning_of_day #since=#{since_date}
    date = date.utc
    since_date = date.iso8601
    until_date = date + 1.day
    until_date = until_date.iso8601
    # url = URI.parse("https://api.github.com/repos/StephenKellyQLD/G2A/commits?sha=featrues/chris&author=chris78323@gmail.com")
    url = URI.parse("https://api.github.com/repos/#{gitname}/commits?sha=#{branch}&since=#{since_date}&until=#{until_date}&author=#{author}")
    # url = URI.parse("https://api.github.com/repos/#{@project}/commits?author=chris78323@gmail.com&since=#{until_date}")
    puts url
    get_list(url)
  end

  def commits(options)
    branch = "sha=#{options[:branch]}" if options[:branch].present?
    gitname = options[:gitname]
    url = URI.parse("https://api.github.com/repos/#{gitname}/commits?#{branch}")

    get_list(url)
  end


  def branches(gitname)

    url = URI.parse("https://api.github.com/repos/#{gitname}/branches")
    # url = URI.parse("https://api.github.com/repos/ChrisMcdonald/TimeSheet/branches")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    bra = Net::HTTP::Get.new(url.request_uri)
    bra["Accept"] = 'application/vnd.github.cloak-preview'
    bra['Authorization'] = "token #{@auth}"
    branches = http.request(bra)

    branches = JSON.parse(branches.body)
    branch_attribues = ['Select a Branch']
    # begin
      branches.each do |b|
      branch_attribues << b['name']

      end
    # rescue
    #   branch_attribues = ['401 Unauthorized']
    # end
    branch_attribues
  end

  def projects
    url = URI.parse("https://api.github.com/user/repos")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  req = Net::HTTP::Get.new(url.request_uri)
  req["Accept"] = 'application/vnd.github.cloak-preview'
  req["Authorization"] = "token #{@auth}" if @auth.present?
  res = http.request(req)

  repo_list = JSON.parse(res.body)
  repo_list

end


    private

    def get_list(url)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      req = Net::HTTP::Get.new(url.request_uri)
      req["Accept"] = 'application/vnd.github.cloak-preview'
      req["Authorization"] = "token #{@auth}" if @auth.present?
      res = http.request(req)
      JSON.parse(res.body)
    end
  end
#https://api.github.com/repos/ChrisMcdonald/TimeSheet/commits?committer=ChrisMcdonald