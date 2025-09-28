#!/bin/bash
set -e  # stop if any command fails

echo "1. Switching to image registry project..."
oc project openshift-image-registry

echo "2. Creating PVC..."
cat <<EOF | oc create -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: image-registry-storage
spec:
  storageClassName: ocs-external-storagecluster-cephfs
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 500Gi
EOF

echo "3. Patching registry config to set storage PVC and Managed state..."
oc patch configs.imageregistry.operator.openshift.io/cluster \
  --type=merge \
  --patch '{
    "spec": {
      "managementState": "Managed",
      "storage": {
        "pvc": {
          "claim": "image-registry-storage"
        }
      }
    }
  }'

echo "4. Checking registry status..."
oc get co image-registry

echo "5. Enabling external route..."
oc -n openshift-image-registry patch configs.imageregistry.operator.openshift.io/cluster --type=merge --patch '{"spec":{"defaultRoute":true}}'

echo "✅ Image registry setup completed."
