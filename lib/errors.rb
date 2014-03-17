module SmsManager
  module Errors
    class BadDataError < Exception; end
    class AuthError < Exception; end
    class LowBalanceError< Exception; end
    class UnknownError < Exception; end
    class BadSenderError <Exception; end
  end
end