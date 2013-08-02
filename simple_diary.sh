#!/bin/bash

DIARY_DIR="/home/chris/landfill/diary"
cd $DIARY_DIR

# Commit previous entries
git add entries/*
git commit -m 'Adding old diary entries.'

ENTRIES="$DIARY_DIR/entries/"
if [ $# -gt 1 ] && [ $1 == "-p" ]; then
    DATE_OPT="$2 days ago"
else
    DATE_OPT="0 days ago"
fi

DATE=`date --rfc-3339=date -d "$DATE_OPT"`
if [  $? != 0 ]; then
    exit 1
fi

ENTRY="${ENTRIES}${DATE}.md"

if [ ! -e $ENTRY ]; then
    if [ "$TITLE" ]; then
        echo "$TITLE" > $ENTRY
    else
        echo "Entry for $DATE" > $ENTRY
    fi
    echo "====================" >> $ENTRY
    echo >> $ENTRY
    cat "/home/chris/landfill/diary/template" >> $ENTRY
    ENCRYPT_OPT=-x
fi

vim -n $ENCRYPT_OPT "$ENTRY"

