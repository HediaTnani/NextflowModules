process featureCounts {
    tag {"subread featureCounts ${sample_id}"}
    label 'subread_2_0_0'
    label 'subread_2_0_0_featureCounts'
    container = 'quay.io/biocontainers/subread:2.0.0--hed695b0_0'
    shell = ['/bin/bash', '-euo', 'pipefail']

    input:
    tuple sample_id, file(bam_file), file(bai)
    file(genome_gtf)   
  
    output:
    tuple sample_id, file("${bam_file.baseName}_gene.featureCounts.txt"), file("${bam_file.baseName}_gene.featureCounts.txt.summary")

    shell:
    //Adapted code from: https://github.com/nf-core/rnaseq - MIT License - Copyright (c) Phil Ewels, Rickard Hammarén
    def featureCounts_direction = 0
    if (params.stranded && !params.unstranded) {
          featureCounts_direction = 1
    } else if (params.revstranded && !params.unstranded) {
          featureCounts_direction = 2
    }     
    """
    featureCounts -a ${genome_gtf} -t ${params.fc_count_type} -g ${params.fc_group_features} -o ${bam_file.baseName}_gene.featureCounts.txt -p -s ${featureCounts_direction} ${bam_file}
    """
}
