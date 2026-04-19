OUTPUT_DIR="./now-sdk-docs"
mkdir -p "$OUTPUT_DIR"

echo "Obtaining topics from now-sdk explain..."
topics=$(npx @servicenow/sdk explain | awk '/^[[:space:]]+[a-zA-Z0-9._-]+/ {print $1}')

echo "Found $(echo "$topics" | wc -l | tr -d ' ') topics"

echo "$topics" | while read -r topic; do
  [ -z "$topic" ] && continue
  echo "Exporting $topic..."
  npx @servicenow/sdk explain "$topic" > "$OUTPUT_DIR/$topic.md"
done

echo "Export completed"
