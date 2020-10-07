setenv RELION_QSUB_TEMPLATE ${appdir}/etc/common.sh
setenv RELION_PDFVIEWER_EXECUTABLE evince
setenv RELION_MOTIONCOR2_EXECUTABLE MotionCor2
setenv RELION_GCTF_EXECUTABLE Gctf
setenv RELION_QSUB_COMMAND sbatch
setenv RELION_QUEUE_NAME default

setenv RELION_QSUB_EXTRA_COUNT 2
setenv RELION_QSUB_EXTRA1 "Number of Nodes allocated"
setenv RELION_QSUB_EXTRA2 "Additional SBATCH commands"
setenv RELION_QSUB_EXTRA1_DEFAULT 1
setenv RELION_QSUB_EXTRA2_DEFAULT "--gres=gpu:4 --mem=0 --ntasks-per-node=5 --distribution=arbitrary"
setenv RELION_RESMAP_EXECUTABLE ResMap-1.1.4-linux64
setenv RELION_SCRATCH_DIR /tmp/$::env(USER)
setenv RELION_QUEUE_USE yes
