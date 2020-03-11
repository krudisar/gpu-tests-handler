JOB_NAME="tf-test-job"
kubectl apply -f deploy-gpu-cronjob.yml
sleep 2

echo 
echo "The CronJob is running on a GPU enabled K8S node  ..."

echo
echo
echo

read -p "Outputs saved. Now you can delete the job. Press enter to continue ..."
kubectl delete cronjob tf-test-job
echo

