# gi - i'm-feeling-lucky for github

-   Searches for a repository best matching your keyword(s)
-   Clones that repository (defaults to _/opt_)
-   Does a git pull if the destination folder already exists
-   Looks for a _requirements.txt_ file and runs _pip install_ if it is found
-   Looks for a _go.mod_ file and runs _go build_ if it is found

## Example usage:

```
$ gi -h
usage: gi [-h] [-i] query [query ...]

'I'm Feeling Lucky' tool for git repositories.

positional arguments:
query

options:
-h, --help show this help message and exit
-i ask for confirmation before running commands

$ gi dalfox
Found repository dalfox at https://github.com/hahwul/dalfox.git
Installing to /opt/dalfox
Cloning into 'dalfox'...
remote: Enumerating objects: 5305, done.
remote: Counting objects: 100% (521/521), done.
remote: Compressing objects: 100% (209/209), done.
remote: Total 5305 (delta 418), reused 349 (delta 312), pack-reused 4784
Receiving objects: 100% (5305/5305), 15.87 MiB | 1.14 MiB/s, done.
Resolving deltas: 100% (3501/3501), done.

/opt/dalfox:
cmd CONTRIBUTING.md dalfox Dockerfile go.mod lib pkg samples SECURITY.md
CODE_OF_CONDUCT.md CONTRIBUTORS.svg dalfox.go docs go.sum LICENSE.txt README.md scripts
```
