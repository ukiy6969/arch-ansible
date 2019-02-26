#!/usr/bin/env bash

gcloud config configurations activate home
gcloud compute instances start archlinux
sleep 5
gcloud compute ssh archlinux -- -fNL 5902:localhost:5901
