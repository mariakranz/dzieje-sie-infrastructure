output "role_arn" {
  value = module.oidc_github.iam_role_arn
}
output "role_name" {
  value = module.oidc_github.iam_role_name
}
output "provider_arn" {
  value = module.oidc_github.oidc_provider_arn
}