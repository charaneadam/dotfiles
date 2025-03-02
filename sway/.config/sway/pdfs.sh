#!/bin/bash

SEARCH_DIRS="$HOME/Projects $HOME/Downloads $HOME/Documents $HOME/Dropbox $HOME/PDFs"
SELECTED_PDF=$(find $SEARCH_DIRS -type f -iname "*.pdf" | fzf)

if [ -z "$SELECTED_PDF" ]; then
  echo "No PDF selected."
  exit 1
fi

(nohup zathura "$SELECTED_PDF" >/dev/null 2> /dev/null &);
sleep 0.1;
exit
