module Finder
    class FinderError < StandardError; end
    class CardError < FinderError; end
    class CardNotFound < CardError
        def message
            "Card not found"
        end
        def error_code
            "301"
        end
    end
end