
/******************************************************************************\
| aws.tf
| handle the provider details
|
| Estimated Runtime Cost: None
| Change Log:
| 2018/02/09 - tls - initial version
| 9999/99/99 - xxx - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
|                    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
| Known Issues:
| #99 - 9999/99/99 - xxx - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
\******************************************************************************/

provider "aws" {
  version                 = "0.0.0"
  region                  = "us-west-2"
  shared_credentials_file = "/Users/tspeckhart/.aws/credentials"
  profile                 = "tspeckhart"
}
