#!/bin/bash
# Anacron setup
mkdir -p $HOME/.local/var/spool/anacron
ln -s $HOME/dotfiles/jobs/anacrontab $HOME/.local/etc/anacrontab

# Set up of daily cron jobs
mkdir -p $HOME/.local/etc/cron.daily
ln -s $HOME/dotfiles/jobs/weather $HOME/.local/etc/cron.daily/weather

