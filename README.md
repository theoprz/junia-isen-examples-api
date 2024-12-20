# **Junia ISEN - API Cloud Project**

Ce projet propose une solution de **cloud computing déployée sur Azure**, combinant des workflows CI/CD automatisés, une gestion d'infrastructure via Terraform, un système de monitoring de la Web App via NewRelic et une application développée en Python.

---

### **L'équipe du projet**

Le projet a été réalisé par un groupe d'étudiants en **Cybersécurité** de **Junia ISEN Lille**. L'équipe est composée de :

- **Théo Porzio**
- **Loick Zirotti**
- **Albane Soufflet**
- **Antoine Fournet**

---

### **Technologies**

Nous avons utilisé :
- Terraform (version 1.5.7) par HashiCorp pour la gestion de l'infrastructure.
- Python (version 3.12) pour le développement de l'application.
- FastAPI (version 0.115.0) pour la création de l'API Python.
- NewRelic (version 10.0.0) pour le monitoring de la solution web.
- Azure pour l'hébergement de l'infrastructure (services App Service, Blob Storage, Application Gateway, etc.).
- GitHub Actions pour automatiser les workflows CI/CD (Intégration continue et déploiement continu).

---

### **Architecture du Projet**

L'architecture repose sur des services **Azure** et suit une approche **Microservices** et **Infrastructure-as-Code**. Voici les principaux composants :
- .github : Ce répertoire contient les fichiers de configuration des workflows CI/CD utilisés pour l'intégration et le déploiement automatisés.
- examples : Contient l'application backend, réalisée en Python avec FastAPI, exposant des endpoints pour interagir avec les utilisateurs.
- infrastructure : Ce répertoire contient les fichiers de configuration Terraform pour gérer et déployer l'infrastructure sur Azure.
- test : Ce répertoire contient les tests unitaires pour les endpoints de l'API, utilisés par le workflow CI/CD pour garantir la stabilité de l'application.

---

## **Prérequis**

Avant de démarrer l'installation, assurez-vous que vous disposez des outils suivants :
- Version 1.5.7 (minimum) de **Terraform** : https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

- Version 2.66 (minimum) de **Azure CLI** : https://learn.microsoft.com/fr-fr/cli/azure/install-azure-cli

- Clé de license **NewRelic** (_Compte nécessaire_): https://docs.newrelic.com/docs/apis/intro-apis/new-relic-api-keys/
---

### **Installation**

1. Clonez ce dépôt environnement de développement local.

2. Ouvrez le projet avec un IDE.

3. Allez dans le répertoire ./infrastructure et renommez le fichier terraform.tfvars.sample en terraform.tfvars. Remplissez ce fichier avec les informations nécessaires.

4. Dans le même répertoire, exécutez les commandes suivantes pour initialiser et appliquer l'infrastructure avec Terraform :
terraform init
terraform plan
terraform apply

5. Une fois l’infrastructure déployée, créez une table examples en faisant une requête POST soit avec curl -X POST https://<adressedevotreappservice>/data ou bien avec Postman.

6. Votre infrastructure est prête et l'application est bien déployée.

---

### **Difficultés rencontrées :**

Lors de la mise en place du CD (Continuous Deployment), une difficulté a été rencontrée concernant l'accès à certains services Azure nécessaires pour l'automatisation du déploiement.

- **Problème d'accès au clientId et clientSecret** : 
  Pour que le déploiement via GitHub Actions fonctionne correctement, il est nécessaire de disposer des identifiants d'un **clientId** et d'un **clientSecret** associés à un service Azure. Ces identifiants sont spécifiques au compte Azure utilisé et sont générés par l'administrateur du service. Cependant, l'accès à ces informations est restreint aux administrateurs Junia, ce qui empêche leur utilisation avec notre compte étudiant. En conséquence, cette partie du pipeline CD qui repose sur des autorisations administratives pour le déploiement automatisé, n'a pas pu être testée (voir les commentaires du workflow deploy pour les détails techniques).

---

### **Vue d'ensemble du système de Monitoring :**

Voici à quoi ressemble le système de monitoring mis en place avec NewRelic:

![Capture d'écran du système de monitoring mis en place](./images/screen1.png)

---

#### **_N'hésitez pas à nous contacter pour tous renseignements._**