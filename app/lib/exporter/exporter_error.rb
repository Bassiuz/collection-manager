module Exporter
    class ExporterError < StandardError; end
    class CardError < ExporterError; end
    class CardNotFound < CardError
        def message
            "Card not found"
        end
        def error_code
            "301"
        end
    end
    class CardAlreadyinDeck < CardError
        def message
            "Card already in deck"
        end
        def error_code
            "302"
        end
    end
end