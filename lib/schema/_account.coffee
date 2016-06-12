if Meteor.isServer
  Accounts.onCreateUser (options, user) ->
    user.profile = if options.profile then options.profile
    user.roles = if options.roles then  options.roles
    user