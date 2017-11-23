require 'gerry'

MAX_NUMBER_OF_CHANGES = 7

client = Gerry.new('gerrit URL', 
                   'username', 
                   'password')
client.set_auth_type(:basic_auth)

def get_avatar_url(username) 
	jira_uri = URI.parse("jira URL")
	avatar_url = URI.join(jira_uri.to_s, "secure/useravatar?size=small&ownerId=#{username}")
  return avatar_url
end


SCHEDULER.every '5m', :first_in => 0 do |job|    
	changes = []
	gerrit_open_changes = client.changes(['q=status:open']).to_a
  gerrit_open_changes.take(MAX_NUMBER_OF_CHANGES).each { |change|
  	username = client.account_info(change["owner"]["_account_id"])["username"]
		changes.push( {
			submitter: username ,
      submitterAvatarUrl: get_avatar_url(username),
			subject: change["subject"],
			project: change["project"],
			branch: change["branch"]
		})
	}

	send_event('gerrit_list_open_changes', 
             { header: "Open Gerrit Changes (Total: #{gerrit_open_changes.count})", 
              changes: changes, 
              numberOfChanges: gerrit_open_changes.count })
end
