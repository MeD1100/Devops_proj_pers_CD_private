resource "helm_release" "argocd" {
  name = "argocd"

  repository = "https://argoproj.github.io/argo-helm"
  chart = "argo-cd"
  namespace = "argocd"
  create_namespace = true
  version = "3.35.4"
  
  values = [file("values/argocd.yaml")]
}

//----------------- How to add ArgoCD to your cluster? ---------------------
// STEPS:
// aws eks update-kubeconfig --region us-east-1 --name prod
// helm list -A
// kubectl get pods -n argocd
// kubectl get secrets -n argocd
// kubectl get secrets argocd-initial-admin-secret -o yaml -n argocd
// echo "paste_ur_password_here" | base64 -d
// kubectl port-forward svc/argocd-server -n argocd 8090:80
// Open localhost:8090 in the browser
//---------------------------------------------------------------------------