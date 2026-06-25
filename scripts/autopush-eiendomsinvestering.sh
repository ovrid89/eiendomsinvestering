#!/bin/bash
# Autopush script for Eiendomsinvestering.md
# Kjører fra cron og pusher endringer til GitHub

REPO_DIR="/home/ubuntu/openclaw"
FILE="Eiendomsinvestering.md"
LOG="/home/ubuntu/openclaw/.autopush.log"

cd "$REPO_DIR" || exit 1

# Sjekk om det er endringer i filen
if git diff --quiet "$FILE" && git diff --cached --quiet "$FILE"; then
    echo "$(date): Ingen endringer i $FILE" >> "$LOG"
    exit 0
fi

# Staging, commit og push
git add "$FILE" >> "$LOG" 2>&1
COMMIT_MSG="autopush: Oppdatering av Eiendomsinvestering.md $(date +'%Y-%m-%d %H:%M')"
git commit -m "$COMMIT_MSG" >> "$LOG" 2>&1

if git push origin master >> "$LOG" 2>&1; then
    echo "$(date): ✅ Pushed til GitHub" >> "$LOG"
else
    echo "$(date): ❌ Push feilet" >> "$LOG"
fi
