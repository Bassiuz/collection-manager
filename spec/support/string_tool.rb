module StringTool
    def self.count_in_string(string, substring)
        string.scan(/(?=#{substring})/).count
    end
end