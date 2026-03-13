resource "aws_codebuild_project" "website" {
  name         = "${var.project_name}-build"
  service_role = aws_iam_role.codebuild.arn

  # Where to get source code from (CodePipeline passes it)
  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  # Where to put built artifacts
  artifacts {
    type = "CODEPIPELINE"
  }

  # The build server settings
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    # This variable is used in buildspec.yml ($S3_BUCKET_NAME)
    environment_variable {
      name  = "S3_BUCKET_NAME"
      value = aws_s3_bucket.website.bucket
    }
  }

  # Log build output to CloudWatch
  logs_config {
    cloudwatch_logs {
      group_name = "/aws/codebuild/${var.project_name}"
    }
  }
}
