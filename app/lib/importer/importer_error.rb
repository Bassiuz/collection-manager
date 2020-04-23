module Importer
    class ImporterError < StandardError; end
    class BoxError < ImporterError; end
    class BoxNotFound < BoxError
        def message
            "No available box found"
        end
        def error_code
            "001"
        end
    end


    class InputError < ImporterError; end
    class InputNotValid < InputError
        def message
            "Given input is not valid"
        end
        def error_code
            "101"
        end
    end
    class InputNotAValidNumber < InputError
        def message
            "Given input is not a valid number"
        end
        def error_code
            "102"
        end
    end
end