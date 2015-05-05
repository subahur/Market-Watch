class LastPriceRule < Rule

	def checkTrigger
          if self.compare_type == "greater"
            if target <= stock.last_trade_price  #should the comparator be a seperate function to prevent seperate class for each for >, >= <= etc ??? 
              if canfire? 
              myobj = Rule.find(self.id)
              myobj[:last_fired] = Time.now.to_i
              myobj.save!
              Rails.logger.debug "goo #{myobj.attributes.inspect}"
              notification = self.notifications.create
              RuleMailer.sample_email(self).deliver_now
              end
            end
          else 
            if target >= stock.last_trade_price  #should the comparator be a seperate function to prevent seperate class for each for >, >= <= etc ??? 
              if canfire? 
              myobj = Rule.find(self.id)
              myobj[:last_fired] = Time.now.to_i
              myobj.save!
              Rails.logger.debug "goo #{myobj.attributes.inspect}"
              notification = self.notifications.create
              RuleMailer.sample_email(self).deliver_now
              end
            end
          end

	end
     
        def target
          return self.target_price
        end
        

        def create_chart 
          target= self.target
          stock_symbol = self.stock.stock_symbol
          return Chart.add_target_to_json(Chart.get_price_history_json(stock_symbol),target, "Target Price")
        end 

        def message
            if target <= stock.last_trade_price
              return " last trade price has exceeded the target price of "
           else
            return " last trade price has dropped below the target price of "
           end
        end
end
