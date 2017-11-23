# smashing_gerrit_list_open_changes
Simple smashing widget that list open gerrit changes. Avatars from Jira are
displayed (but can be removed/changed if Jira is not available).

# Install
In Gemfile, include:

gem 'gerry'
gem 'jira-ruby', :require => 'jira'

In gerrit_list_open_changes.rb change URL's, username and password.

In your dashboard .erb file include:

<li data-row="1" data-col="1" data-sizex="2" data-sizey="2">
  <div data-id="gerrit_list_open_changes" data-view="GerritListOpenChanges"></div>
</li>


