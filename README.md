# Hightower


** NOTE: ** This project is not complete. Feel free to fork and fix it **

![Hightower dashboard](https://dl.dropboxusercontent.com/u/4298391/images_for_github_readme_files/hightower.png)

Hightower lets you monitor your users for predefined behavior and respond accordingly. 

You could look out for users who:

- have just joined your social network but not added any friends.
- have joined but not created their first project.
- have participated a lot in your forum.
- have yet to have uploaded an avatar.

...and **create an automated response** to these users such as:

- sending them a friendly email 
- sending them an internal message to welcome them on their next visit
- flag for internal uses
- etc etc

*Note the above automations are not part of this gem - just ideas to show you how you could use this gem with your existing system and other gems to achieve your goals.*

## Installation

Gemfile.rb
```ruby
gem "hightower", github: "robodisco/hightower"
```

```bash
bundle install
rails g hightower:install
```

Running the install will

* copy necessary migrations from the gem to your app
* run those migrations
* create a hightower initializer file in your app's config/initializer directory

###Configuring Hightower###

In the initializer file you will want to change a few of the default settings.

**1) Your User class**

If your user class is not named User (e.g. you have Member or Admin) then pass the name **as a string** via

`Hightower.user_class = "User"`

**2) Authorizing access to the dashboard**

You will also want to authorize access to the Hightower dashboard. Define an instance method in your User class that returns true if the user can view the dashboard.

e.g.

```ruby
class User
    def can_access_hightower?
        self.admin == true
    end
end
```

Then tell Hightower the name of the method via:
`Hightower.authorization_method = :can_access_hightower?`

**3) Providing a label method for your user**

In the dashboard Hightower will display users by calling  #email on each user.If you want to display something else instead simply pass the name of the method via

`Hightower.user_label_method = :full_name`

**4) And more**

See the initializer file for other config options.

## Defining behaviors

First we need to define the types of users we want to look out for. We do this in a "behavior" class defined within 'models/hightower' (you will need to create this subdirectory). Behavior classes are just plain ole ruby objects which expect you to define two methods on them: respond and observe.

Let's say we want to find all users who are 3 days old but have not uploaded a profile picture. 

We'll call these users "just joined but no avatar" (You are free to name how you wish).

In models/hightower create the file `just_joined_but_no_avatar.rb` and define the behavior class like so: 

```ruby
module Hightower
    class JustJonedButNoAvatar
        include Behaviour
        def observe
            matched_users = []
            User.where("created_at > ?", 3.days.ago).find_each do |user|
                matched_users << unless user.avatar.present?
            end
            matched_users
        end
    end
end
```

The observe method above simply returns an array of users who match your behavior. 

**Note**: Remember to define your behaviors within the Hightower module as per above.

## Reacting to user behavior

Now we need to react to this behavior. Let's send these shy users an email to remind them to upload their avatar.

Back in your behavior class define a respond method. This method accepts an array of users who **matched** the behavior you are tracking. 

```ruby
module Hightower
    class JustJoinedButNoAvatar
        include Behaviour

        def observe
            # ...
        end

        def respond(users)
            users.each do |user|
              UserMailer.upload_your_avatar(user_id: user.id).deliver_later
            end
        end
    end
end
```

## Segments

When a user matches your defined behavior they will get added to a segment of the same name as the behavior. In this case a segment name 'just joined but no avatar'. You can view all your segments and their users via the dashboard at /hightower.

When you decide to respond to these users they will be marked as processed but will remain in the segment permanently. 

**No matter how many times a user matches a behavior they will only be responsed to once to avoid accidental spamming.**

## Getting things rolling

Now that you have a behavior setup you can create a rake task to observe and respond to this behavior like so:

```ruby
namespace :dev do
  desc "engage users with no avatar"
  task prime: "engage:just_jonied_but_no_avatar" do
    Hightower::Track.perform(Hightower::JustJonedButNoAvatar)
    Hightower::Engage.perform(Hightower::JustJonedButNoAvatar)
  end
end
```

Use
- Hightower::Track to match users with the given behavior class 
- Hightower::Engage to respond to users who matched the given behavior class 

Put your rake task on a schedule and you are done. 

## Defining behavior more easily with events

To help you define behavior easily, Hightower also ships with a simple Event model you can use within your app to track important actions made by your users.

You could use the Event model to track when a user...

- likes something
- created their profile
- sent a message
- viewed a certain page

Then use these events in your behaviour definitions e.g. All new users who 'liked something' 5 times in their first day.

To track an event simply call

Hightower::Event.create(user_id: @user.id, action: 'liked movie', meta: {title: 'The Godfather', actor: 'Al Pacino'})

You can then use these in your behavior classes like so to match users who really like movies

```ruby
module Hightower
    class UsersWhoLikesMovies
        def observe
            match = []
            users = User.where('created_at < ?', 7.days.ago)

            users.each do |user|
              match.push user if ::Event.where(action: 'liked movie', actor: user).count == 20
            end

            match
        end
    end
end
```

**Note:** whilst the event model has a meta attribute it is just for additional information that you may find useful viewing from the dashboard. Unfortunately it can't be searched against as its a serialized column in the db so you won't be able to use it in your observe methods (unless you pull the records out of the db and user ruby to inspect the meta hash record by record.)

## Watching progress

Visit /hightower to see your dashboard. From here you can see all the users in the system and the segments they have become part of as well as all the events flowing through. 

## Shortcomings and the future

Currently when a user is added to a segment they remain there permanently even if their behavior changes to the one you originally defined. In terms of reacting to behavior this has no impact as users are still responded to on entry and are protected from being responded to more than once. 

But it does mean the users you see in the segments dashboard may not actually still match the behavior you defined.. This is something I'll tackle in the next version.

Things to consider for the future
* allow users to drift in and out of segments
* incorporate messaging system into gem? 



























