## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| api\_gateway\_rest\_api\_arn | execution\_arn of aws\_api\_gateway\_rest\_api | `string` | `""` | no |
| api\_gateway\_rest\_api\_id | id of aws\_api\_gateway\_rest\_api | `string` | `""` | no |
| api\_gateway\_rest\_api\_root\_resource\_id | root\_resource\_id of aws\_api\_gateway\_rest\_api | `string` | `""` | no |
| artifact\_file\_name | filename of the articat to be deployed (zip/jar file) | `string` | n/a | yes |
| deployment\_s3\_bucket\_name | name of s3 bucket to which zip artifact will be uploaded to | `string` | n/a | yes |
| function\_name | AWS lambda function name. Has nothing to do with function name in the backend code itself | `string` | n/a | yes |
| handler | Function from the backend code to be called. Format and its semantics depends on programming language and packaging method | `string` | n/a | yes |
| http\_method | http method | `string` | `""` | no |
| log\_retention | CloudWatch log retention in days | `number` | `7` | no |
| memory\_size | AWS lambda memory size in megabytes | `number` | `256` | no |
| path\_part | path part of the URL | `string` | `""` | no |
| runtime | AWS lambda runtime | `string` | n/a | yes |
| timeout | AWS lambda execution timeout in seconds | `number` | `30` | no |

## Outputs

No output.

## Known shortcomings

It generates new IAM policy for each of lambda function.
