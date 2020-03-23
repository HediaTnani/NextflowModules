
process CollectMultipleMetrics {
  tag {"GATK_Collectmultiplemetrics ${sample_id}"}
  label 'GATK_4_1_3_0'
  label 'GATK_4_1_3_0_Collectmultiplemetrics'
  clusterOptions = workflow.profile == "sge" ? "-l h_vmem=${params.mem}" : ""
  container = 'library://sawibo/default/bioinf-tools:gatk4.1.3.0'

  input:
    tuple sample_id, file(bam)

  output:
    file ("${sample_id}.multiple_metrics*")

  script:
  """
  gatk --java-options "-Xmx${task.memory.toGiga()-4}g -Djava.io.tmpdir=\$TMPDIR" \
  CollectMultipleMetrics \
  -I $bam \
  -O ${sample_id}.multiple_metrics\
  -R ${params.genome_fasta} \
  ${params.optional}
  """
}
