class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  

  def crack(user)
    if user.admin == 1
      "Si"
    else
      "No"
    end
  end

  def self.find_everything(number, name)
    users = []
    names = find_name(name)
    numbers = find_number(number)

    names.each do |a|
      coin = 0
      numbers.each do |u|
        if a.id == u.id
          coin = 1
        end
      end
      if coin == 1
        users.push(a)
      end
    end

    users
  end

  def self.find_name(name)
    users = []
    upcasename = name.upcase

    if name == ""
      users = User.all
    else
      User.all.each do |user|
        simplename = user.first_name.upcase
        if  simplename.include? upcasename
          users.push(user)
        end
      end
    end

    users
  end

  def self.find_number(number)
    users = []
    comparenumber = number.to_s

    if comparenumber == ""
      users = User.all
    else
      User.all.each do |user|
        usernumber = user.phone_number.to_s
        if usernumber.include? comparenumber
          users.push(user)
        end
      end
    end

    users
  end
end
