class Friend < ApplicationRecord
    # Step 1 with associations, a friend belongs to a user. Step 2: who does user belong to?
    belongs_to :user
end
