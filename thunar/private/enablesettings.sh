#!/usr/bin/env bash

# xcq is a wrapper function for xconf-query so 
# that the command below:
# xfconf-query --channel thunar --property /last-icon-view-zoom-level --create --type string --set THUNAR_ZOOM_LEVEL_NORMAL
#
# can be written like this:
# xcq last-icon-view-zoom-level THUNAR_ZOOM_LEVEL_NORMAL

xcq() {

  local prop="$1" val="$2" type=""

  if [[ $val =~ ^[0-9]+$ ]]; then
    type="int"
  elif [[ $val =~ ^(true|false)$ ]]; then
    type="bool"
  else
    type="string"
  fi

  xfconf-query --create             \
               --channel thunar     \
               --property /"$prop"  \
               --type "$type"       \
               --set "$val"         \

}

# this script will enable the settings needed when
# it is executed it will kill all running
# instances of thunar exisiting prior to executing
# this script.

thunar -q
killall thunar

xcq last-icon-view-zoom-level        THUNAR_ZOOM_LEVEL_NORMAL
xcq last-details-view-zoom-level     THUNAR_ZOOM_LEVEL_SMALLEST
xcq last-sort-column                 THUNAR_COLUMN_DATE_MODIFIED
xcq last-sort-order                  GTK_SORT_ASCENDING
xcq last-view                        ThunarIconView
xcq last-show-hidden                 false
xcq last-details-view-fixed-columns  true
xcq misc-text-beside-icons           false

xcq last-details-view-column-order \
    THUNAR_COLUMN_NAME,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_TYPE,THUNAR_COLUMN_DATE_MODIFIED
xcq last-details-view-visible-columns \
    THUNAR_COLUMN_DATE_MODIFIED,THUNAR_COLUMN_NAME,THUNAR_COLUMN_SIZE
xcq last-details-view-column-widths \
    50,172,50,50,274,50,50,92,468
