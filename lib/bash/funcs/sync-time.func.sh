# usage:
# source lib/bash/funcs/sync-time.func.sh && do_sync_time
do_sync_time(){

      sudo netplan apply
      sudo systemctl unmask systemd-timedated.service
      sudo systemctl restart systemd-timedated.service
      sudo timedatectl set-ntp true
      sudo systemctl restart systemd-timesyncd.service
      systemctl status systemd-timesyncd.service | cat

}
