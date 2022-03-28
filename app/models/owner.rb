class Owner < User
    has_one :brand, dependent: :destroy, foreign_key: 'user_id'
end