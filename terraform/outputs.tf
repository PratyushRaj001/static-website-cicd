output "website_url" {
  value = "http://${aws_s3_bucket.website.bucket}.s3-website-${var.aws_region}.amazonaws.com"
  description = "Your website URL - open this in a browser!"
}

output "pipeline_name" {
  value = aws_codepipeline.website.name
}

output "IMPORTANT_ACTION_REQUIRED" {
  value = "Go to AWS Console > CodePipeline > Connections and APPROVE the GitHub connection!"
}
