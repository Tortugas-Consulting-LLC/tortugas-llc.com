class Jira
  include HTTParty
  base_uri 'https://tortugas.atlassian.net/rest/api/2'
  basic_auth 'jira-api', 'alj302309u12qfj3@#@#2309fm'
  default_params :output => 'json'
  format :json

  def initialize
  end

  def find_issues_by_project(project)
    return [] if project.jira_key.blank?

    response = self.class.get("/search?project=" + project.jira_key)

    return [] if response.code != 200

    JSON.parse(response.body)["issues"]
  end
end
