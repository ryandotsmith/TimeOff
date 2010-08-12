module StateMachine
  PENDING  = 0
  APPROVED = 1
  DENIED   = -1

  module ClassMethods
    def self.included(base)
      base.class_eval do
      end
    end
  end

  module InstanceMethods
    def pending?
      state == PENDING
    end

    def approved?
      state == APPROVED
    end

    def denied?
      state == DENIED
    end

    def deny!
      self.state = DENIED
    end

    def approve!
      self.state = APPROVED
    end

    def pend!
      self.state = PENDING
    end

    def status
      return 'approved' if approved?
      return 'denied'   if denied?
      return 'pending'  if pending?
    end
  end
end
