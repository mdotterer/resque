module Rescue
  module Failure
    # A Failure backend that sends exceptions raised by jobs to Hoptoad.
    #
    # To use it, put this code in an initializer, Rake task, or wherever:
    #
    #   require 'resque/failure/hoptoad'
    #
    # Make sure your HoptoadNotifier is configured properly.
    class Hoptoad < Base
      def save
        HoptoadNotifier.notify(exception, :parameters => params)
      end

      def params
        { :worker => worker,
          :queue => queue,
          :job => payload['class'],
          :args => payload['args'].to_json }
      end
    end
  end
end

