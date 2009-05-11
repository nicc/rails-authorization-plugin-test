require File.dirname(__FILE__) + '/../test_helper'
require 'secure_controller'

# Re-raise errors caught by the controller.
class SecureController; def rescue_action(e) raise e end; end

class SecureControllerTest < ActionController::TestCase

  # Replace this with your real tests.
  def test_truth
    assert true
  end

end

