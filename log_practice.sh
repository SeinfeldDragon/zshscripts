  1 #!/bin/zsh
  2 
  3 log_file="$HOME/practice_log.txt"
  4 temp_file="$HOME/.practice_start_time"
  5 total_time_file="$HOME/.total_practice_time"
  6 
  7 start_practice() {
  8   start_time=$(date)
  9   echo "Practice started at: $start_time" >> $log_file
 10   echo $start_time > $temp_file
 11   echo "====================" >> $log_file
 12 }
 13 
 14 end_practice() {
 15   if [[ -f $temp_file ]]; then
 16     start_time=$(cat $temp_file)
 17     end_time=$(date)
 18     duration=$(($(date -d "$end_time" +%s) - $(date -d "$start_time" +%s)))
 19 
 20     echo "Practice ended at: $end_time" >> $log_file
 21     echo "Duration: $(($duration / 3600)) hours, $((($duration / 60) % 60)) minutes, $(($duration % 60)) seconds" >> $log_file
 22     rm $temp_file
 23 
 24     # Update total practice time
 25     if [[ -f $total_time_file ]]; then
 26       total_time=$(cat $total_time_file)
 27     else
 28       total_time=0
 29     fi
 30     total_time=$(($total_time + $duration))
 31     echo $total_time > $total_time_file
 32 
 33     # Display total practice time
 34     echo "====================" >> $log_file
 35     echo "Total practice time: $(($total_time / 3600)) hours, $((($total_time / 60) % 60)) minutes, $(($total_time % 60)) seconds" >> $log_file
 36   else
 37     echo "No practice session in progress. Start a session first."
 38     echo "====================" >> $log_file
 39   fi
 40 }
 41 
 42 case "$1" in
 43   start)
 44     start_practice
 45     ;;
 46   end)
 47     end_practice
 48     ;;
 49   *)
 50     echo "Usage: $0 {start|end}"
 51     exit 1
 52 esac
 53 
~                                                                                                                                                          
~                                
