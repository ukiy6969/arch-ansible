gcloud compute instances create archlinux \
      --address=archlinux \
      --machine-type=n1-standard-2 \
      --boot-disk-size=20GB \
      --image-project=arch-linux-gce \
      --image-family=arch
