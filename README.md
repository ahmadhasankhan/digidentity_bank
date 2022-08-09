# README

Steps to run the application up and running.

1. Run the rails app with usual setup
2. Visit http://localhost:3000
3. Register an account (With successful registration an account will be created)
4. Go to rails console and find the account then credit some fund
    ```ruby
      $ rails c
      acc = Account.last
      acc.update(balance: 500)
    ```
5. From the UI you should be able to move the money from one account to another.
6. After login you should see an `Accounts` tab, once click on that you should see all the bank accounts associated with you.
7. Click on the account number, it will take you to the dash board where you will see your account balance and recent transactions.
8. Click on send money button to transfer the money.
9. Enter account number & amount to be transferred and click on Transfer button.

## Run Test suite

Just run `rspec`

Test Coverage

![Test coverage](https://github.com/ahmadhasankhan/digidentity_bank/blob/main/coverage.png?raw=true)

