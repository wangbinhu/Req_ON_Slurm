# ------------------------------ tmp.clean.to.rmdup.bam.sh

mkdir    -p     $S02_Step01_OU_PATH/${sample}

$BWA    mem    -t    8    -M    -Y    -R    "@RG\tID:${sample}\tPL:Illumina\tLB:${sample}_dir\tSM:${sample}\tCN:BGI"    $REF    $S02_Step01_IN_PATH/${sample}/${sample}.clean.R1.fq.gz    $S02_Step01_IN_PATH/${sample}/${sample}.clean.R2.fq.gz    |    $SAMTOOLS    view    -Sb    -o    $S02_Step01_OU_PATH/${sample}/${sample}.bam

$SAMTOOLS    fixmate    -m    $S02_Step01_OU_PATH/${sample}/${sample}.bam    $S02_Step01_OU_PATH/${sample}/${sample}.srt.bam   && \ 
/bin/rm    -rf    $S02_Step01_OU_PATH/${sample}/${sample}.bam

# -m  每个线程需要内存大小
$SAMTOOLS    sort    -@    8    -m    3G        $S02_Step01_OU_PATH/${sample}/${sample}.srt.bam     -O    BAM    -o    $S02_Step01_OU_PATH/${sample}/${sample}.sort.bam   && \ 
/bin/rm      -rf    $S02_Step01_OU_PATH/${sample}/${sample}.srt.bam  


$SAMTOOLS    markdup    -@    8    $S02_Step01_OU_PATH/${sample}/${sample}.sort.bam    $S02_Step01_OU_PATH/${sample}/${sample}.dup.sort.bam    && \
/bin/rm      -rf        $S02_Step01_OU_PATH/${sample}/${sample}.sort.bam

$SAMTOOLS    rmdup    $S02_Step01_OU_PATH/${sample}/${sample}.dup.sort.bam    $S02_Step01_OU_PATH/${sample}/${sample}.rmdup.sort.bam    && \
/bin/rm      -rf        $S02_Step01_OU_PATH/${sample}/${sample}.dup.sort.bam
cd    $S02_Step01_OU_PATH/${sample}
$md5sum    ${sample}.rmdup.sort.bam   >  $S02_Step01_OU_PATH/${sample}/${sample}.rmdup.sort.bam.md5    

$SAMTOOLS    index    -@    8    -b    $S02_Step01_OU_PATH/${sample}/${sample}.rmdup.sort.bam
$SAMTOOLS    index    -@    8    -c    $S02_Step01_OU_PATH/${sample}/${sample}.rmdup.sort.bam

$BAMDEAL    visualize    StatQC    -i    $S02_Step01_OU_PATH/${sample}/${sample}.rmdup.sort.bam    -o    $S02_Step01_OU_PATH/${sample}/
$BAMDEAL    statistics    Coverage    -i    $S02_Step01_OU_PATH/${sample}/${sample}.rmdup.sort.bam   -o    $S02_Step01_OU_PATH/${sample}/Cov    -r    $REF


echo -e "End   Time:      \c";  date;  ELAPSED_TIME=$(($SECONDS - $START_TIME));  echo "$(($ELAPSED_TIME/3600)) h $((($ELAPSED_TIME/60)%60)) min $(($ELAPSED_TIME%60)) sec";

# ------------------------------ tmp.clean.to.rmdup.bam.sh
