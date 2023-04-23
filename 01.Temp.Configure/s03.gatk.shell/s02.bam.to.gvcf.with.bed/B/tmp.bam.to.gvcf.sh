# tmp.bam.to.gvcf.sh

# SOFTWARE:
GATK4=/hwfssz4/BC_PUB/Software/03.Soft_ALL/gatk-4.1.2.0/gatk-package-4.1.2.0-local.jar
JAVA=/hwfssz4/BC_PUB/Software/03.Soft_ALL/jdk1.8.0_202/bin/java
TIME=/usr/bin/time
mkdir    -p    $TMP_DIR/${sample}
mkdir    -p    $OUT_DIR

$TIME    $JAVA    -XX:-UseGCOverheadLimit    -XX:ParallelGCThreads=1    -Xmx4G    -Djava.io.tmpdir=$TMP_DIR/${sample}/    -jar    $GATK4    HaplotypeCaller    -R    $REF_FA    -I    $BAM      -L    $BED_DIR/$CHR_NUM.bed    --standard-min-confidence-threshold-for-calling    20    -native-pair-hmm-threads    1    --output-mode    EMIT_ALL_SITES    -ERC    GVCF    -O    $OUT_DIR/${sample}.$CHR_NUM.gvcf.gz    #    -L    $CHR_NUM

echo -e "End   Time:      \c";  date;
