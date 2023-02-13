Use the following command to generate the .terraform.lock.hcl file to work cross plat:

```
terraform providers lock -platform=windows_amd64 -platform=darwin_amd64 -platform=linux_amd64
```