class PagesController < HighVoltage::PagesController
  before_filter :load_account
end
