Hightower.user_class = "<%= user_class %>" # must be a string
Hightower.authorization_method = :persisted?
Hightower.redirect_unauthorized_path = '/'
Hightower.current_user_method = :<%= current_user_method %>