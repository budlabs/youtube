#!/usr/bin/env bash

# this script will enable the settings needed
# when it is executed it will cill all running instances
# thunar prior to applying the settings

thunar -q
killall thunar

xfconf-query --channel thunar --property /last-icon-view-zoom-level --create --type string --set THUNAR_ZOOM_LEVEL_NORMAL
xfconf-query --channel thunar --property /last-details-view-fixed-columns --create --type bool --set true
xfconf-query --channel thunar --property /last-details-view-zoom-level --create --type string --set THUNAR_ZOOM_LEVEL_SMALLEST
xfconf-query --channel thunar --property /last-details-view-column-order --create --type string --set THUNAR_COLUMN_NAME,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_TYPE,THUNAR_COLUMN_DATE_MODIFIED
xfconf-query --channel thunar --property /last-details-view-visible-columns --create --type string --set THUNAR_COLUMN_DATE_MODIFIED,THUNAR_COLUMN_NAME,THUNAR_COLUMN_SIZE
xfconf-query --channel thunar --property /last-details-view-column-widths --create --type string --set 50,172,50,50,274,50,50,92,468
xfconf-query --channel thunar --property /last-show-hidden --create --type bool --set false
xfconf-query --channel thunar --property /last-view --create --type string --set ThunarIconView
xfconf-query --channel thunar --property /last-sort-column --create --type string --set THUNAR_COLUMN_DATE_MODIFIED
xfconf-query --channel thunar --property /last-sort-order --create --type string --set GTK_SORT_ASCENDING
xfconf-query --channel thunar --property /misc-text-beside-icons --create --type bool --set false
