require 'test_helper'

class PresentationTest < ActiveSupport::TestCase
  def setup
    @dhh = users(:david)
    @alexander = users(:alexander)
    @presentation = create_presentation(:owner => @dhh, :user => @alexander)
  end
  
  def create_presentation(attributes = {})
    Presentation.create!({:name => "sample"}.merge(attributes.symbolize_keys))
  end
  
  def test_newly_created_presentation_has_the_relevant_accepted_role
    assert_equal 2, @presentation.accepted_roles.size
    assert_equal [Role.find_by_name('owner'), Role.find_by_name('creator')], @presentation.accepted_roles
  end
  
  def test_newly_created_presentation_allows_authorization_for_dhh_as_owner
    assert @dhh.is_owner_of?(@presentation)
    assert @dhh.has_role?('owner', @presentation)
    assert @presentation.accepts_role?('owner', @dhh)
  end
    
  def test_newly_created_presentation_allows_authorization_for_alexander_as_creator
    assert @alexander.is_creator_of?(@presentation)
    assert @alexander.has_role?('creator', @presentation)
    assert @presentation.accepts_role?('creator', @alexander)
  end
  
  def test_newly_created_presentation_does_not_allow_authorization_for_dhh_as_creator
    assert !@dhh.is_creator_of?(@presentation)
    assert !@dhh.has_role?('creator', @presentation)
    assert !@presentation.accepts_role?('creator', @dhh)
  end
  
  def test_newly_created_presentation_does_not_allow_authorization_for_alexander_as_owner
    assert !@alexander.is_owner_of?(@presentation)
    assert !@alexander.has_role?('owner', @presentation)
    assert !@presentation.accepts_role?('owner', @alexander)
  end
  
  def test_update_to_owner_updates_roles_accordingly
    assert @dhh.is_owner_of?(@presentation)
    assert !@alexander.is_owner_of?(@presentation)
    
    @presentation.owner = @alexander
    @presentation.save
    @presentation.reload
    
    assert !@dhh.is_owner_of?(@presentation)
    assert @alexander.is_owner_of?(@presentation)
  end
  
  def test_model_updates_arent_affected_when_roles_change
    @presentation.name = "new name"
    @presentation.owner = @alexander
    @presentation.save
    @presentation.reload
    
    assert_equal "new name", @presentation.name
    assert_equal @alexander, @presentation.owner
    
    assert !@dhh.is_owner_of?(@presentation)
    assert @alexander.is_owner_of?(@presentation)
  end
  
  def test_model_updates_arent_affected_when_roles_dont_change
    @presentation.name = "new name"
    @presentation.save
    @presentation.reload
    
    assert_equal "new name", @presentation.name
    
    assert @dhh.is_owner_of?(@presentation)
  end
  
end
