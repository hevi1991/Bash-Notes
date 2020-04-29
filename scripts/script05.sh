#!/bin/bash

echo -n "Enter something > "
if read -t 3 response; then
  echo "You enter $response."
else
  echo "You did not enter."
fi