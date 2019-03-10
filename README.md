# Archlinux on GCP

Ansible playbook for personal Archlinux running on GCE.

## Setup

Create [GCP][1] projects.

Configure [gcloud][2] command.

Create GCE instance with [GCP Archlinux image][3].

    $ gcloud compute instances create archlinux \
            --machine-type=n1-standard-2 \
            --boot-disk-size=20GB \
            --image-project=arch-linux-gce \
            --image-family=arch


[1]: https://console.cloud.google.com
[2]: https://cloud.google.com/sdk/docs/
[3]: https://github.com/GoogleCloudPlatform/compute-archlinux-image-builder
