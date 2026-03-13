#!/usr/bin/env bash

# <xbar.title>Church of England Liturgical Calendar</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>Christian Selvaratnam</xbar.author>
# <xbar.author.github>cselvaratnam</xbar.author.github>
# <xbar.desc>Displays the title of the church season or festival of the day and the Collect of the Day from the Church of England website.</xbar.desc>
# <xbar.image>https://github.com/cselvaratnam/images/blob/6c68f941510460f27aca9677389f155f3abe6891/church-liturgical-calendar.png</xbar.image>
# <xbar.dependencies>bash</xbar.dependencies>
# <xbar.abouturl>https://bio.site/selvaratnam</xbar.abouturl>

# Fetch the Church of England homepage
web=$(curl -f -s -S https://www.churchofengland.org/) || { echo "Unavailable"; exit 1; }

# Extract the season/festival title and the Collect of the Day
full_title=$(echo "$web" | sed 's/.*<div class="textfill-footer">.*<small>\(.*\)<\/small>.*/\1/')
short_title=$(echo "$full_title" | sed -e 's/^The //' -e 's/Blessed Virgin Mary/BVM/' -e 's/ (.*$//' -e 's/,.*//')
collect=$(echo "$web" | sed -e 's/.*<div class="textfill-footer">.*<p>\(.*\)<\/p>.*/\1/' -e 's/<br \/>/\\r/g' -e 's/\\r /\\r/g')

echo "$short_title"
echo "---"
echo "$full_title"
echo "$collect"
echo "Refresh | refresh=true"
