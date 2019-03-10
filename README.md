# Ansible for Archlinux on GCP

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

## Playbook

Create [GCE dynamic inventory][4]

```yaml
plugin: gcp_compute
zones:
  - asia-northeast1-c
projects:
  - my-project
scopes:
  - https://www.googleapis.com/auth/compute
service_account_file: ./path/to/service_account_file.json
auth_kind: serviceaccount
```

Do playbook

    $ ansible-playbook -i archlinux.gcp.yml playbook.yml

## Connect Archlinux with VNC viewer

ssh portforwarding.

    $ gcloud compute ssh archlinux -- -L 5901:localhost:5901

Connect Vnc server.

    $ vncviewer localhost:5901

[1]: https://console.cloud.google.com
[2]: https://cloud.google.com/sdk/docs/
[3]: https://github.com/GoogleCloudPlatform/compute-archlinux-image-builder
[4]: https://docs.ansible.com/ansible/latest/plugins/inventory/gcp_compute.html
