#!/bin/bash

IMAGE=$1

if ! magick identify -ping "$IMAGE" 1>/dev/null; then
  echo "Error identifying image: $?"
  exit 1
fi

WIDTH=$(magick identify -ping -format "%w" "$IMAGE")
HEIGHT=$(magick identify -ping -format "%h" "$IMAGE")

if [ $((WIDTH)) -ne $((HEIGHT)) ] || [ $((WIDTH & (WIDTH - 1))) -ne 0 ] || [ $((WIDTH)) -lt 32 ]; then
  echo "Image is not in a correct format"
  exit 1
fi

DIVIDER=1
while [ $((WIDTH / DIVIDER)) -ge 32 ]; do
  new_width=$((WIDTH / DIVIDER))
  new_height=$((HEIGHT / DIVIDER))
  ((DIVIDER *= 2))

  echo "Resizing original image to ${new_width}x${new_height}"
  # magick "$IMAGE" -filter Lanczos -resize "${new_width}x${new_height}" /usr/share/icons/hicolor/${new_width}x${new_height}/apps/"$IMAGE"
  if [ ! -d "${PWD}"/hicolor/${new_width}x${new_height}/apps/ ]; then
    mkdir -p "${PWD}"/hicolor/${new_width}x${new_height}/apps/
  fi
  magick "$IMAGE" -filter Lanczos -resize "${new_width}x${new_height}" "${PWD}"/hicolor/${new_width}x${new_height}/apps/"$IMAGE"
done
