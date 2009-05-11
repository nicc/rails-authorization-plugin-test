require File.dirname(__FILE__) + '/../test_helper'
require 'account_controller'

# Re-raise errors caught by the controller.
class AccountController; def rescue_action(e) raise e end; end

class AccountControllerTest < ActionController::TestCase

  # Replace this with your real tests.
  def test_truth
    assert true
  end

end

