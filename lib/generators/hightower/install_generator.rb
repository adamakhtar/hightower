require 'rails/generators'
module Hightower
  module Generators
    # Big thank you to Forem gem for this install generator.
    class InstallGenerator < Rails::Generators::Base
      class_option "user-class", :type => :string
      class_option "current-user-method", :type => :string
      # class_option "no-migrate", :type => :boolean

      source_root File.expand_path("../install/templates", __FILE__)
      desc "Used to install Hightower"

      def install_migrations
        puts "Copying over Hightower migrations..."
        Dir.chdir(Rails.root) do
          `rake hightower:install:migrations`
        end
      end

      def determine_user_class
        @user_class = options["user-class"].presence ||
                      ask("What is your user class called? [User]").presence ||
                      'User'
      end

      def determine_current_user_method
        @current_user_method = options["current-user-method"].presence ||
                              ask("What is the current_user method called in your app? [current_user]").presence ||
                              :current_user
      end

      def add_hightower_initializer
        path = "#{Rails.root}/config/initializers/hightower.rb"
        if File.exists?(path)
          puts "Skipping config/initializers/hightower.rb creation, as file already exists!"
        else
          puts "Adding hightower initializer (config/initializers/hightower.rb)..."
          template "initializer.rb", path
          require path # Load the configuration per issue #415
        end
      end

      def run_migrations
        unless options["no-migrate"]
          puts "Running rake db:migrate"
          `rake db:migrate`
        end
      end

      def mount_engine
        puts "Mounting Hightower::Engine at \"/hightower\" in config/routes.rb..."
        insert_into_file("#{Rails.root}/config/routes.rb", :after => /routes.draw.do\n/) do
          %Q{mount Hightower::Engine, :at => '/hightower'\n\n}
        end
      end

      def create_assets
        create_file Rails.root + "vendor/assets/stylesheets/hightower.css.scss"
      end

      def finished
        output = "\n\n" + ("*" * 53)
        output += %Q{\nSuccess! Hightower was installed.\n\n
Here's what happened:\n\n}

        output += step("Hightower's migrations were copied over into db/migrate.\n")
        output += step("A new file was created at config/initializers/hightower.rb
   This is where you put Hightower's configuration settings.\n")

        unless options["no-migrate"]
output += step("`rake db:migrate` was run, running all the migrations against your database.\n")      
        end
        output += step("The engine was mounted in your config/routes.rb file using this line:

   mount Hightower::Engine, :at => \"/hightower\"

   If you want to change where Hightower's dashboard is located, just change the \"/hightower\" path at the end of this line to whatever you want.\n\n")
        output += %Q{Currently any persisted user can access the dashboard. You will want to lock this down to certain users such as admin. To do that you should define a method in your user model which returns true for authorized users. E.g. is_admin? etc. Then configure Hightower to use this method in the initializer file we just copied over.\n\n}

        output += %Q{Also you should tell Hightower in the initializer what method to use to display a user's identity. By default it will try using a method called 'email'.\n\n}
    
        output += "\nIf you have any questions, comments or issues, please post them on the issues page: http://github.com/robodisco/hightower/issues.\n\n"
        output += "Thanks for using Hightower!"
        puts output
      end

      private

      def step(words)
        @step ||= 0
        @step += 1
        "#{@step}) #{words}\n"
      end

      def user_class
        @user_class
      end

      def current_user_method
        @current_user_method
      end

      def next_migration_number
        last_migration = Dir[Rails.root + "db/migrate/*.rb"].sort.last.split("/").last
        current_migration_number = /^(\d+)_/.match(last_migration)[1]
        current_migration_number.to_i + 1
      end
    end
  end
end
