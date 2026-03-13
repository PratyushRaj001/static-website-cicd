variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name prefix for all resources"
  default     = "mywebsite-cicd"
}

variable "github_owner" {
  description = "Your GitHub username"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  default     = "static-website-cicd"
}

variable "github_branch" {
  description = "Branch to deploy from"
  default     = "main"
}
