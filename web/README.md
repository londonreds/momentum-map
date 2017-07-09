# public_map

This is the static frontend component of the Indivisible Guide map. `index.html` displays a map that loads event and action data from the output of [`public_map-etl`](https://github.com/indivisibleguide/public_map-etl).

## Deploying

Make sure you have [`awscli`](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html) installed and configured.

Run the `deploy.sh` script to push the important contents of this project to the appropriate places on S3.
