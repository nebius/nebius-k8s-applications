#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Error: you need to provide the Project ID and the Subnet ID that K8s cluster will be created in."
    echo "./tests/main.sh project-xxxxxxx vpcsubnet-xxxxxxxx"
    exit 1
fi

parent_id=$1
vpc_id=$2

nebius --profile prod mk8s cluster create --parent-id $parent_id --name test-device-plugin --control-plane-subnet-id $vpc_id --control-plane-endpoints-public-endpoint true
mk8s_cluster_id=$(nebius --profile prod mk8s cluster get-by-name --parent-id $parent_id --name test-device-plugin | yq .metadata.id)
nebius --profile prod mk8s node-group create --parent-id $mk8s_cluster_id --name g100 --strategy-max-surge-count 1 --strategy-max-unavailable-count 1 --template-boot-disk-size-gibibytes 100 --template-resources-platform gpu-h100-sxm --template-resources-preset 1gpu-16vcpu-200gb --template-gpu-settings-drivers-preset cuda12 --fixed-node-count 1
nebius --profile prod applications v1alpha1 k-8-s-release create --cluster-id $mk8s_cluster_id --product-slug nebius/$(whoami)-nvidia-device-plugin --namespace nvidia-device-plugin --application-name nvidia-device-plugin --parent-id $parent_id
nebius --profile prod mk8s cluster get-credentials --id $mk8s_cluster_id --external --context-name app-test --force
is_app_ready=$(kubectl --context app-test -n nvidia-device-plugin get deploy nvidia-device-plugin-node-feature-discovery-master -o yaml | yq '.status.readyReplicas == 1')
if [[ $is_app_ready == "true" ]]; then
    echo "Application deployed successfully."
    nebius --profile prod mk8s cluster delete --id $mk8s_cluster_id
else
    echo "There was an issue with deployment of the app."
    kubectl --context app-test get pods -A
fi
