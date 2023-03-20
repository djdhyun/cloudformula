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
├── common
│   ├── main.yaml
│   └── prod.properties
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

### GitOps Scenario

1. Make Change Plans

Once you create a pull request, corresponding changesets are automatically created by github action.

<img src="assets/gitops_1.png" width="540px" />


2. Apply Change Plans





### Operations via make

* `make lint`: Run linter on all Cloudformation template files.
* `STACK=${STACK_NAME} make plan`: Create necessary changesets for given stacks
    * e.g. `STACK=sample-application make plan`
* `make apply`: Apply the changesets created via `make plan`
* `make abort`: Abort and remove changesets created via `make plan`

### Run command manually with `cloudfomula`

* Common usage: `./cloudfomula $subcommand $templatedir $env`
* e.g. `./cloudfomula plan sample-application prod`
* Subcommands
    * `plan`: Create a changeset for given template file and properties.
    * `abort`: Destroy the changeset created via `plan` command.
    * `describe: Describe the changeset.
    * `apply`: Apply the changeset.
    * `arn`: Get ARN of the changeset.
    * `url`: Get an url where you can access the changeset in Cloudformation console.

### Or you can use aws-cli directly to do the same things like below.

```sh
STACK_NAME=sample-application

aws cloudformation deploy \
    --template-file ${STACK_NAME}/main.yaml \
    --stack-name ${STACK_NAME} \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides $(cat ${STACK_NAME}/prod.properties)
```
