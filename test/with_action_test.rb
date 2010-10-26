require 'test/unit'
require 'rubygems'
require 'active_support'
require 'mocha'
require File.dirname(__FILE__) + '/../lib/with_action'

class WithActionTest < Test::Unit::TestCase
  include WithAction
  
  def setup
    @params = {}
    @responder = WithAction::ActionResponder.new(self)
  end
  
  def params
    @params
  end
  
  def test_calls_second_with_two_responses
    @params[:save] = true
    with_action do |a|
      a.cancel { fail('cancel should not get called') }
      a.save   { @executed = :save }
    end
    assert_equal :save, @executed
  end

  def test_does_not_call_any_on_match
    @params[:cancel] = true
    with_action do |a|
      a.cancel { @executed = :cancel }
      a.any    { fail('any should not get called') }
    end
    assert_equal :cancel, @executed
  end

  def test_any
    @params[:bar] = true
    with_action do |a|
      a.foo { raise('foo should not get called') }
      a.any do
        a.bar { @executed = :bar }
      end
    end
    assert_equal :bar, @executed
  end
  
  def test_defaults_to_any_block
    with_action do |a|
      a.foo { raise('foo should not get called') }
      a.any { @executed = :any }
    end
    assert_equal :any, @executed
  end

  def test_defaults_to_first_without_any_block
    with_action do |a|
      a.foo { @executed = :foo }
      a.bar { fail('this should never get executed') }
    end
    assert_equal :foo, @executed
  end
  
  def test_calls_method_without_block
    self.expects(:foo)
    with_action do |a|
      a.foo
    end
  end

  def test_takes_arguments_and_calls_method
    self.expects(:bar)
    @params[:bar] = true
    with_action(:foo, :bar)
  end

end
