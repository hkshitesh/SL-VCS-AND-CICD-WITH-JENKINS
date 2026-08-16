#!/bin/bash
DATE=$(date +%Y-%m-%d-%H-%M-%S)
BACKUP_DIR="/opt/jenkins-backups"
JENKINS_HOME="/var/lib/jenkins"
S3_BUCKET="s3://technova-jenkins-backup-hitesh"
BACKUP_FILE="jenkins-backup-$DATE.tar.gz"
echo "Starting Jenkins backup..."
sudo systemctl stop jenkins
sudo tar -czf "$BACKUP_DIR/$BACKUP_FILE" "$JENKINS_HOME"
sudo systemctl start jenkins
echo "Uploading backup to S3..."
aws s3 cp \
"$BACKUP_DIR/$BACKUP_FILE" \
"$S3_BUCKET/"
echo "Backup completed successfully."
echo "Removing local backup..."
rm "$BACKUP_DIR/$BACKUP_FILE"
echo "Process finished."
