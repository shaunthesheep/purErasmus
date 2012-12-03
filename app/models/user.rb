require "bcrypt"

class User < ActiveRecord::Base
    # Attributes
    #-----------
    attr_accessible :email, :first_name, :last_name, :new_password, :new_password_confirmation, :home_university_id, :foreign_university_id
    attr_accessor :new_password, :new_password_confirmation

    # Associations
    #-------------
    has_many :comments
    has_many :topics

    belongs_to :admin_university, :class_name => "University"
    belongs_to :home_university, :class_name => "University"
    belongs_to :foreign_university, :class_name => "University"
    belongs_to :user_type
    
    # Validations
    #------------
    validates :new_password, :confirmation => true
    validates :email, :presence => true, :format => { :with => /[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}/ }
    validates :first_name, :presence => true
    validates :last_name, :presence => true

    # Triggers
    #---------
    before_save :hash_new_password, :if => :password_changed?

    # Helper methods
    #---------------
    def full_name
        "#{self.first_name} #{self.last_name}"
    end

    def self.authenticate (email, password)
        user = find_by_email email
        if user && user.password = BCrypt::Engine.hash_secret(password, user.password_salt)
            user
        else
            nil
        end
    end

    def validate_password? (password)
        hashed_pass = BCrypt::Password.create(password)
        hashed_pass == self.password
    end

    # Trigger conditions
    #-------------------
    def password_changed?
        !self.new_password.blank?
    end

    # Trigger methods
    #----------------
    def hash_new_password
        self.password_salt = BCrypt::Engine.generate_salt
        self.password = BCrypt::Engine.hash_secret(self.new_password, self.password_salt)
    end    

end
