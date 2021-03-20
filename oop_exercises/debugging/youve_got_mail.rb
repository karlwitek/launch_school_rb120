class Mail
  def to_s
    "#{self.class}"
  end
end

class Email < Mail
  attr_accessor :subject, :body

  def initialize(subject, body)
    @subject = subject
    @body = body
  end
end

class Postcard < Mail
  attr_reader :text

  def initialize(text)
    @text = text
  end
end

module Mailing
  def receive(mail, sender)
    mailbox << mail unless reject?(sender)
  end

  # Change if there are sources you want to block.
  def reject?(sender)
    false
  end

  def send(destination, mail)
    "Sending #{mail} from #{name} to: #{destination}"
    # Omitting the actual sending.
  end
end

class CommunicationsProvider
  include Mailing

  attr_reader :name, :account_number

  def initialize(name, account_number=nil)
    @name = name
    @account_number = account_number
  end
end

class EmailService < CommunicationsProvider

  attr_accessor :email_address, :mailbox

  def initialize(name, account_number, email_address)
    super(name, account_number)
    @email_address = email_address
    @mailbox = []
  end

  def empty_inbox
    self.mailbox = []
  end
end

class TelephoneService < CommunicationsProvider
  def initialize(name, account_number, phone_number)
    super(name, account_number)
    @phone_number = phone_number
  end
end

class PostalService < CommunicationsProvider
  attr_accessor :street_address, :mailbox

  def initialize(name, street_address)
    super(name)
    @street_address = street_address
    @mailbox = []
  end

  def change_address(new_address)
    self.street_address = new_address
  end
end

rafaels_email_account = EmailService.new('Rafael', 111, 'Rafael@example.com')
johns_phone_service   = TelephoneService.new('John', 122, '555-232-1121')
johns_postal_service  = PostalService.new('John', '47 Sunshine Ave.')
ellens_postal_service = PostalService.new('Ellen', '860 Blackbird Ln.')

puts johns_postal_service.send(ellens_postal_service.street_address, Postcard.new('Greetings from Silicon Valley!'))
# => undefined method `860 Blackbird Ln.' for #<PostalService:0x00005571b4aaebe8> (NoMethodError)

# the #send method being invoked is not from the module(defined in the module). #send is coming from the class Object.
# Kernel implements send.  This send invokes the method identified by symbol, passing it 
# any arguments specified. (The number of arguments is specified in the method def). When the method is 
# identified by a string, the string is converted to a symbol. In this problem, we need to include 
# the module in the proper class. (the Parent of PostalService, which is CommunicationsProvider)
# This will make the module's version of #send available to PostalService objects and will override
# class Object's version.

# LS

# def send_mail(destination, mail)
#   "Sending #{mail} from #{name} to: #{destination}"
#   # Omitting the actual sending.
# end
# end

# class PostalService < CommunicationsProvider
# include Mailing

# # code omitted
# end

# puts johns_postal_service.send_mail(ellens_postal

# This is a case of accidental method overriding. Intended to call Mailing#send, but since include
# Mailing was not in PostalService, it does not happen.  Ruby did not complain that there is no method
# #send. It looks for #send on the method lookup path, and it finds a method with this name in the 
# Object class. So, it calls Object#send, which expects a method name as the first argument.
# Since the first argument we provide is '860 Blackbird ln', is not the name of any method, we get an
# error.  In order to avoid overriding Object#send, we should rename our Mailing#send method to 
# something unique. (solution).  Also, included Mailing in PostalService instead of moving the include
# to the Parent class.  
