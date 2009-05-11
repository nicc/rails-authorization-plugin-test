require File.dirname(__FILE__) + '/../test_helper'
require 'really_secure_controller'

# Re-raise errors caught by the controller.
class ReallySecureController; def rescue_action(e) raise e end; end

class ReallySecureControllerTest < ActionController::TestCase

  # Replace this with your real tests.
  def test_truth
    assert true
  end

end

