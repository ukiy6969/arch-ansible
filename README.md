# Ansible for Archlinux on GCP

Ansible playbook for personal Archlinux running on GCE.

## Requirements

* [gcloud][2]
* [ansible][3]

## Setup

Create [GCP][1] projects.

Configure [gcloud][2] command.

Create GCE instance with [GCP Archlinux image][4].

    $ gcloud compute instances create archlinux \
            --machine-type=n1-standard-2 \
            --boot-disk-size=20GB \
            --image-project=arch-linux-gce \
            --image-family=arch

## Playbook

Install requirements.

    $ pip install -r requirements.txt

Create [GCE dynamic inventory][5]

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


## Licence

[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)

## Author

[ukiy6969](https://github.com/ukiy6969)

[1]: https://console.cloud.google.com
[2]: https://cloud.google.com/sdk/docs/
[3]: https://www.ansible.com/
[4]: https://github.com/GoogleCloudPlatform/compute-archlinux-image-builder
[5]: https://docs.ansible.com/ansible/latest/plugins/inventory/gcp_compute.html
