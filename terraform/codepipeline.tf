resource "aws_codestarconnections_connection" "github" {
  name          = "${var.project_name}-github-conn"
  provider_type = "GitHub"
}

# The Pipeline
resource "aws_codepipeline" "website" {
  name     = "${var.project_name}-pipeline"
  role_arn = aws_iam_role.codepipeline.arn

  artifact_store {
    location = aws_s3_bucket.artifacts.bucket
    type     = "S3"
  }

  # Stage 1: Get code from GitHub
  stage {
    name = "Source"
    action {
      name             = "GitHub-Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_code"]
      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.github.arn
        FullRepositoryId = "${var.github_owner}/${var.github_repo}"
        BranchName       = var.github_branch
      }
    }
  }

  # Stage 2: Build and deploy with CodeBuild
  stage {
    name = "Deploy"
action {
      name            = "Build-and-Deploy"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["source_code"]
      configuration = {
        ProjectName = aws_codebuild_project.website.name
      }
    }
  }
}
