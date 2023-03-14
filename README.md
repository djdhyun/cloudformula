## CloudFormation Stacks as a code

### Prerequisite

* `aws-cli` w/ a configuration as an authorized user.
* `cfn-lint`
    * `brew install cfn-lint` (for mac users only)
    * `pip install cfn-lint`
        * For further information, please refer to [this post](https://www.techielass.com/install-cfn-lint-on-windows)
* Run `source source.me`

### Directory Structure

```bash
├── Makefile
├── README.md
├── sample-application
│   ├── main.yaml
│   └── prod.properties
└── your-another-application
    ├── main.yaml
    ├── dev.properties
    └── prod.properties
```

<img src="assets/cloudformation_stack.png" width="540px" />

* Each directory names corresponds with each CloudFormation stacks.
* `main.yaml`: A Cloudformation template that Defines all resources for the stack.
* `${env}.properties`: Parameters to be applied to the template for the target environment.


### Template Validation (Lint)

* `cfn-lint ${target_yaml_file}`
* To run linter across all templates in the repo.
    * `make lint`

### Deploy a stack manually via aws console

* `deploy_stack sample-application prod`
* ..or run the aws command below directly

```sh
STACK_NAME=sample-application

aws cloudformation deploy \
    --template-file ${STACK_NAME}/main.yaml \
    --stack-name ${STACK_NAME} \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides $(cat ${STACK_NAME}/prod.properties)
```
