require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    describe 'password' do
      it 'should require a password' do
        @user = User.create(
          name: "Patrick",
          email: "Patrick@gmail.com"
        )
      expect(@user.errors.full_messages).to include("Password can't be blank")
      end
    end

    describe 'password confirmation' do
      it 'should require password confirmation' do
        @user = User.create(
          name: "Patrick",
          email: "Patrick@gmail.com",
          password: "Wumbo",
        )
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      end
    end

    describe 'password & password confirmation' do
      it 'should match' do
        @user = User.create(
          name: "Patrick",
          email: "Patrick@gmail.com",
          password: "Wumbo",
          password_confirmation: "Wumbology"
        )
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end

    describe 'unique email' do
      it 'should be unique' do
        @user = User.create(
          name: "Patrick",
          email: "Patrick@gmail.com",
          password: "Wumbo",
          password_confirmation: "Wumbo"
        )
        @user2 = User.create(
          name: "Patrick",
          email: "PATRICK@gmail.com",
          password: "Wumbology",
          password_confirmation: "Wumbology"
        )
      expect(@user2.errors.full_messages).to include("Email has already been taken")
      end
    end

    describe 'password length' do
      it 'should be minimum length' do
        @user = User.create(
          name: "Patrick",
          email: "Patrick@gmail.com",
          password: "Wumb",
          password_confirmation: "Wumb"
        )
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
      end
    end

  end

  describe '.authenticate_with_credentials' do

    describe 'should return user if authenticated' do
      it 'should return same user' do
        @user = User.create(
          name: 'Patrick',
          email: 'patrick@hotmail.com',
          password: 'Wumbo',
          password_confirmation: 'Wumbo'
        )
        @user2 = User.authenticate_with_credentials('patrick@hotmail.com', 'Wumbo')
        expect(@user2).to eq(@user)
      end
    end

    describe 'should return nil if not authenticated' do
      it 'should return nil' do
        @user = User.create(
          name: 'Patrick',
          email: 'patrick@hotmail.com',
          password: 'Wumbo',
          password_confirmation: 'Wumbo'
        )
        @user2 = User.authenticate_with_credentials('patrick@hotmail.com', 'Wumbology')
        expect(@user2).to be nil
      end
    end
  
    describe 'should authenticate with spaces in email' do
      it 'should return user' do
        @user = User.create(
          name: 'Patrick',
          email: 'patrick@hotmail.com',
          password: 'Wumbo',
          password_confirmation: 'Wumbo'
        )
        @user2 = User.authenticate_with_credentials('     patrick@hotmail.com', 'Wumbo')
        expect(@user2).to eq(@user)
      end
    end

    describe 'user should save to database' do
      it 'should save user' do
        @user = User.create(
          name: 'Patrick',
          email: 'patrick@hotmail.com',
          password: 'Wumbo',
          password_confirmation: 'Wumbo'
        )
        @user.save
        @user2 = User.authenticate_with_credentials('patrick@hotmail.com', 'Wumbo')
        expect(@user2).to eq(@user)
      end
    end

    describe 'should return user with wrong case in email' do
      it 'should return user' do
        @user = User.create(
          name: 'Patrick',
          email: 'PATRICK@hotmail.com',
          password: 'Wumbo',
          password_confirmation: 'Wumbo'
        )
        @user.email.downcase!
        @user.save
        @user2 = User.authenticate_with_credentials('PaTrIcK@hotmail.com', 'Wumbo')
        expect(@user2).to eq(@user)
      end
    end
    
  end

end
