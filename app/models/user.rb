class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         # Step 2 Assocations, a user has many friends!
          has_many :friends
          # Step 2.5 associations, create a migration.
          # console: rails g migration add_user_id_to_friends user_id:integer:index
          # console: rails db:migrate
          # check the results in the schema

end
