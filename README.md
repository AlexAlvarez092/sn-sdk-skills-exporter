# ServiceNow SDK Skills Exporter

This script extracts all topics from the `now-sdk explain` command and saves each topic's explanation into a separate Markdown file in the `now-sdk-docs` directory.

## Usage

1. Make sure you have the ServiceNow SDK installed and configured.

```
npm install -g @servicenow/sdk
now-sdk --version
```

2. Grant execute permissions to the script:

```sh
chmod +x script.sh
```

3. Run the script to generate the documentation:

```sh
./script.sh
```
