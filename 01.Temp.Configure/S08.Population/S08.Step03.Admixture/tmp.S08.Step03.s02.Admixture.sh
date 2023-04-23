#  =============================================  fixed regoin:
$admixture    -j4    --cv=10    -s    time    plink.bed    ${sample}    >    Log.${sample}   #  -j4:threads number;
#  =============================================  fixed regoin

echo -e "End   Time: \c";  date;  ELAPSED_TIME=$(($SECONDS - $START_TIME));  echo "$(($ELAPSED_TIME/3600)) h $((($ELAPSED_TIME/60)%60)) min $(($ELAPSED_TIME%60)) sec";
