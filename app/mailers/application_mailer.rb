class ApplicationMailer < ActionMailer::Base
  default from: "verify@facebook.com"
  layout "mailer"
end
