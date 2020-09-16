{
  fr: {
    number: {
      nth: {
        ordinals: lambda do |_key, number:, **_options|
          if number.to_i.abs == 1
            "er"
          else
            "ème"
          end
        end,
        ordinalized: lambda do |_key, number:, **_options|
          "#{number}#{ActiveSupport::Inflector.ordinal(number)}"
        end,
      },
    },
  },
}
