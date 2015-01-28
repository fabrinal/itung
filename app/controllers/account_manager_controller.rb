class AccountManagerController < ApplicationController
 
  def initialize
    @total_expense = 0
    @total_income = 0
    @expense_accounts = ""
  end

  def summarize_account
    Account.all.each { |account|
        if account.account_type == "income"
          @total_income += account.value
        else
          @total_expense += (account.value * -1)
        end
    }
  end

  def accounts_summary
    summarize_account
    @balance = @total_income + @total_expense
    @expense_accounts =  Account.where(:account_type => "expense")
    @income_accounts =  Account.where(:account_type => "income")
    respond_to do |format|
      format.html{
        render :layout => 'summary'
      }
      format.json
    end
  end
end
