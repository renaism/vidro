output "user_account_password" {
  value     = random_password.user_account.result
  sensitive = true
}
