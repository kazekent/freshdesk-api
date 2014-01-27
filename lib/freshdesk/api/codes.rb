class Freshdesk
  module Api
    module Codes
      SOURCE_TYPES = {
        email:  1,
        portal: 2,
        phone:  3,
        forum:  4,
        twitter:  5,
        facebook: 6,
        chat:     7,
      }

      STATUS_CODES = {
        open:     2,
        pending:  3,
        resolved: 4,
        closed:   5,
      }

      PRIORITY_LEVELS = {
        low:    1,
        medium: 2,
        high:   3,
        urgent: 4,
      }
    end
  end
end
