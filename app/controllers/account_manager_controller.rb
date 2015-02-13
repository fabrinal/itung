class AccountManagerController < ApplicationController

  attr_reader :record_id

  def initialize
    @total_expense = 0
    @total_income = 0
    @record_id = 1
  end

  def index
    @account = Account.new
    if cookies[:record_id] == nil
      time_record = Time.now
      cookies[:record_id] = time_record.year.to_s + time_record.month.to_s + time_record.day.to_s + time_record.hour.to_s
      cookies[:record_id] = cookies[:record_id].to_s + time_record.min.to_s + time_record.sec.to_s
    end
    @record_id = cookies[:record_id]
    accounts_summary
  end

  def accounts_summary
    get_accounts
    if @accounts.present?
      summarize_account
      @balance = @total_income - @total_expense
      @income_accounts = @accounts.where(:account_type => "income")
      @expense_accounts = @accounts.where(:account_type => "expense")
      respond_to do |format|
        format.html {
          render :layout => 'application'
        }
        format.json
      end
    else
      @total_expense = 0;
      @total_income = 0;
      @balance = 0;
    end
  end

  def get_accounts
    @accounts = Account.where(identity: @record_id)
  end

  def summarize_account
    @accounts.each { |account|
      if account.account_type == "income"
        @total_income += account.value
      else
        @total_expense += account.value
      end
    }
  end

end
