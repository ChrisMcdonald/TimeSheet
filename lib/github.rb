class Github
require 'pry'
  def initialize(gitname,options = {})
    @project = gitname
    @branch = options[:branch] if options[:branch].present?
    @day = options[:day] if options[:day].present?
    @auth = options[:token] if options[:token].present?

  end

  def commit_on_day
# https://api.github.com/repos/StephenKellyQLD/G2A/commits?,since:2018-04-06%2000:00:00%20+1000,until:2018-04-06T23:59:59+10:00
    date = @day.beginning_of_day #since=#{since_date}
    since_date = date.utc.iso8601
    until_date = date + 1.day
    until_date = until_date.utc.iso8601
    # url = URI.parse("https://api.github.com/repos/StephenKellyQLD/G2A/commits?sha=origin/featrues/chris,author=chris78323@gmail.com")
    url = URI.parse("https://api.github.com/repos/#{@project}/commits?sha=origin/features/chris&since=#{since_date}&until=#{until_date}")
    #
    # url = URI.parse("https://api.github.com/repos/#{@project}/commits?author=chris78323@gmail.com")
    get_list(url)
  end

def  commits

    since_date = 2.weeks.ago #since=#{since_date}
    until_date = Time.now

    # url = URI.parse('https://api.github.com/search/commits?q=committer-email:chris78323@gmail.com')
    #curl https://api.github.com/repos/ChrisMcdonald/TimeSheet/commits?timesheet

    url = URI.parse("https://api.github.com/repos/#{@project}/commits?#{@branch}")
    puts
    get_list(url)
end


  def branches

    url = URI.parse("https://api.github.com/repos/#{@project}/branches")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    bra = Net::HTTP::Get.new(url.request_uri)
    bra["Accept"] = 'application/vnd.github.cloak-preview'
    bra['Authorization'] = "token #{@auth}"
    branches = http.request(bra)

    branches = JSON.parse(branches.body)
    branch_attribues = []
    branches.each do |b|
      branch_attribues << b['name']

    end
    branch_attribues
  end


  private

  def get_list(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new(url.request_uri)
    req["Accept"] = 'application/vnd.github.cloak-preview'
    req["Authorization"] = "token #{@auth}" if @auth.present?
    res = http.request(req)

    commit_list = JSON.parse(res.body)
    commit_list
  end
end
