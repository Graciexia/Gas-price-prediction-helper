#!/usr/bin/env bash
/bin/bash -l -c 'cd /Users/xiawei/my_projects/tiy/week10/day1/Gas_Prediction && bin/rails runner -e development '\''OilPrice.my_update_oil_data'\''' >>/tmp/cron.log 2>&1
