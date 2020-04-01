process GenomeGenerate {
    tag {"STAR GenomeGenerate ${genome_fasta.baseName} "}
    label 'STAR_2_6_0c'
    label 'STAR_2_6_0c_GenomeGenerate'
    container = 'quay.io/biocontainers/star:2.6.0c--2'
    shell = ['/bin/bash', '-euo', 'pipefail']

    input:
    file(genome_fasta), file(genome_gtf)
   
   
    output:
    file("${genome_fasta.baseName}/")
     
   
    script:
    """
    mkdir -p ${genome_fasta.baseName}
    STAR --runMode genomeGenerate \
    --runThreadN ${task.cpus} \
    --sjdbGTFfile ${genome_gtf} \
    --genomeDir ${genome_fasta.baseName} \
    --genomeFastaFiles ${genome_fasta} 
    """
}
