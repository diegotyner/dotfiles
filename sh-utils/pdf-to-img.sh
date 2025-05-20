#!/bin/bash

# Initialize variables
MOVE_FILES=false
DEFAULT_LOCATION="$HOME/Dropbox/Obsidian_Repo/Starter_Vault/Excalidraw/PDF-Annotation/"
# DEFAULT_LOCATION="/mnt/c/users/diego/Dropbox/Obsidian_Repo/Starter_Vault/Excalidraw/IMG-Annotation"

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    -mv)
      MOVE_FILES=true
      shift # Remove the -mv flag from the arguments
      ;;
    *)
    # Assume non-flag arguments are the input PDF and output filename
      if [[ -z "$INPUT_PDF" ]]; then
        INPUT_PDF="$1"
      else
        FINAL_OUTPUT="$1"
      fi
      shift
      ;;
  esac
done

# Check usage
if [[ -z "$INPUT_PDF" ]]; then
  echo   "Usage: $0 [-mv] <input.pdf> [output_filename]"
  exit 1
fi

# Output image prefix (you can change this if needed)
if [[ -n "$FINAL_OUTPUT" ]]; then
  if [[ "$FINAL_OUTPUT" != *.jpg ]]; then
      FINAL_OUTPUT="${FINAL_OUTPUT}.jpg"
  fi
else
  INPUT_FILENAME=$(basename "$INPUT_PDF" .pdf)
  FINAL_OUTPUT="${INPUT_FILENAME}.jpg"
fi

OUTPUT_PREFIX="pdf2img-tmp"
echo "Converting PDF to images..."
pdftoppm -jpeg -r 150 "$INPUT_PDF" "$OUTPUT_PREFIX"

echo "Stacking images vertically..."
convert ${OUTPUT_PREFIX}-*.jpg -append "$FINAL_OUTPUT"

# Optional: 
rm ${OUTPUT_PREFIX}-*.jpg

# If the -mv flag was set, move the generated files to the default location
if $MOVE_FILES; then
  echo "Moving file to $DEFAULT_LOCATION..."
  mv "$FINAL_OUTPUT" "$DEFAULT_LOCATION/"
  echo "File moved to $DEFAULT_LOCATION."
fi

echo "Process complete! The final image was saved as '$FINAL_OUTPUT'."
