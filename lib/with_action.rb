require 'active_support'
require 'action_controller'
require 'with_action/with_action'

ActionController::Base.class_eval do
  include WithAction
end
