# ------------------------------ tmp.s03.step01.clean.to.dup.bam.sh

mkdir    -p    $S03_Step01_OU_PATH/Tmp/${sample}
mkdir    -p    $S03_Step01_OU_PATH/01.sample/${sample}

$TIME    $JAVA    -XX:-UseGCOverheadLimit    -XX:ParallelGCThreads=2    -Xmx6G    -Djava.io.tmpdir=$S03_Step01_OU_PATH/Tmp/${sample}/    -jar    $GATK4    HaplotypeCaller    -R    $REF    -I    $S03_Step01_IN_PATH/${sample}/${sample}.rmdup.sort.bam      -L    $S03_Step01_OU_PATH/bed.zone/$CHR_NUM.bed    --standard-min-confidence-threshold-for-calling    20    -native-pair-hmm-threads    1    --output-mode    EMIT_ALL_SITES    -ERC    GVCF    -O    $S03_Step01_OU_PATH/01.sample/${sample}/${sample}.$CHR_NUM.gvcf.gz    #    -L    $CHR_NUM

echo -e "End   Time:      \c";  date;

# ------------------------------ tmp.s03.step01.clean.to.dup.bam.sh
