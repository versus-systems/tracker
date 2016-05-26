module Helpers
  module TableHelpers

    def horizontal_table table
      table.map_headers { |header| header.parameterize.underscore.to_sym }.hashes
    end

    def vertical_table table
      table.rows_hash.each_with_object({}) do |(key, value), result|
        result[key.downcase.parameterize.underscore.to_sym] = value
      end
    end

  end
end
