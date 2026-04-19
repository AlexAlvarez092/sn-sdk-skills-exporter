# ServiceNow SDK Skills Exporter

This script extracts all topics from the `npx @servicenow/sdk explain` command and saves each topic's explanation into a separate Markdown file in the `.agents/skills` directory.

## Usage

1. Copy the script to the root directory of your project.

2. Grant execute permissions to the script:

```sh
chmod +x script.sh
```

3. Run the script to generate the documentation:

```sh
./script.sh
```
