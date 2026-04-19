AGENTS_DIR=".agents"
OUTPUT_DIR="$AGENTS_DIR/skills"
mkdir -p "$AGENTS_DIR"
mkdir -p "$OUTPUT_DIR"

echo "Obtaining topics from now-sdk explain..."
topics=$(npx @servicenow/sdk explain | awk '/^[[:space:]]+[a-zA-Z0-9._-]+/ {print $1}')

echo "Found $(echo "$topics" | wc -l | tr -d ' ') topics"

echo "$topics" | while read -r topic; do
  [ -z "$topic" ] && continue
  echo "Exporting $topic..."
  TOPIC_DIR="$OUTPUT_DIR/$topic"
  mkdir -p "$TOPIC_DIR"
  npx @servicenow/sdk explain "$topic" > "$TOPIC_DIR/SKILL.md"
done

echo "Export completed"
