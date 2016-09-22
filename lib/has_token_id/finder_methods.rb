module HasTokenId
  module FinderMethods

    # Find by token ensuring case sensitivity
    def find_by_case_sensitive_token(token)
      return if token.nil?
      where("#{token_with_table_name} = ?", token).first
    end

    # Find by token regardless of case
    def find_by_case_insensitive_token(token)
      return if token.nil?
      where("lower(#{token_with_table_name}) = ?", token.downcase).first
    end

    # Find by token
    def find_by_token(token)
      return if token.nil?
      send(has_token_id_options[:case_sensitive] ? :find_by_case_sensitive_token : :find_by_case_insensitive_token, token)
    end

    # Find by token and raise error if no record is found
    def find_by_token!(token)
      record = find_by_token(token)
      raise ActiveRecord::RecordNotFound, "Could not find #{self.name} with token #{token.inspect}" if record.nil?
      record
    end

    # Find by token if the first param looks like a token, otherwise use super
    def find(*args)
      if args[0].is_a?(String) && args[0].length == has_token_id_options[:length]
        record = find_by_token(args[0])
      end
      record || super(*args)
    end

    def find!(*args)
      record = find(*args)
      raise ActiveRecord::RecordNotFound if record.nil?
      record
    end

  private

    def token_with_table_name
      "#{table_name}.#{has_token_id_options[:param_name]}"
    end

  end
end
