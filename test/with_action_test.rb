require 'test/unit'
require 'rubygems'
require 'active_support'
require 'mocha'
require 'stubba'
require File.dirname(__FILE__) + '/../lib/with_action'

class WithActionTest < Test::Unit::TestCase
  
  def setup
    @params = {}
    @responder = CollectiveIdea::WithAction::ActionResponder.new(self)
  end
  
  def params
    @params
  end
  
  def test_calls_second_with_two_responses
    @params[:save] = true
    @responder.cancel { @executed = :cancel }
    @responder.save { @executed = :save }
    @responder.respond
    assert_equal :save, @executed
  end

  def test_does_not_call_any_on_match
    @params[:cancel] = true
    @responder.cancel { @executed = :cancel }
    @responder.any { @executed = :any }
    @responder.respond
    assert_equal :cancel, @executed
  end

  def test_any
    @params[:bar] = true
    @responder.foo { @executed = :foo }
    @responder.any do
      @responder.bar { @executed = :bar }
    end
    @responder.respond
    assert_equal :bar, @executed
  end
  
  def test_defaults_to_any_block
    @responder.foo { @executed = :foo }
    @responder.any { @executed = :any }
    @responder.respond
    assert_equal :any, @executed
  end

  def test_defaults_to_first_without_any_block
    @responder.foo { @executed = :foo }
    @responder.bar { fail('this should never get executed') }
    @responder.respond
    assert_equal :foo, @executed
  end
  
  def test_calls_method_without_block
    self.expects(:foo)
    @responder.foo
    @responder.respond
  end

end
