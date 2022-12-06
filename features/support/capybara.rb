if ENV["SLOW"].present?
  require "selenium-webdriver"
  module ::Selenium::WebDriver::Remote
    class Bridge
      alias old_execute execute

      def execute(*args)
        sleep(0.1)
        old_execute(*args)
      end
    end
  end
end
