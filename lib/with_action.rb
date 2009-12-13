module CollectiveIdea
  module WithAction
    def with_action(*actions)
      responder = ActionResponder.new(self)
      yield responder if block_given?
      actions.each {|a| responder.send(a) }
      responder.respond
    end
    
    class ActionResponder
      def initialize(controller)
        @controller = controller
        @order, @responses = [], {}
      end
      
      def respond
        action = @order.detect do |a|
          !@controller.params[a].blank? || !@controller.params["#{a}.x"].blank?
        end
        action ||= @order.include?(:any) ? :any : @order.first
        @responses[action].call if @responses[action]
      end
      
      def any(&block)
        method_missing(:any) do
          # reset
          @order, @responses = [], {}
          returning block.call do
            respond
          end
        end
      end
      
      def method_missing(action, &block)
        @order << action
        block ||= lambda { @controller.send(action) }
        @responses[action] = block
      end
    end
    
  end
end
