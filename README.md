# Ansible Hadoop

Simple ansible playbook to install a YARN/HDFS cluster on a given set of hosts. Edit the `inventory` file to specify which hosts to use for the master and the slaves. Run the `keys.yml` playbook to setup ssh access (edit to specify file with root password or a pem file). Fetch a hadoop-2.6.0 archive using `fetch_hadoop_archive.sh`. Run the `hadoop.yml` playbook to setup an non-secure YARN/HDFS cluster using the downloaded archive. Alternatively, you can provide a custom (2.6+) archive (copy to `roles/common/files/hadoop.tar.gz`)
