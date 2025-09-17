# Guía para levantar la Infraestructura de Ecommerce en el Lab de AWS Academy

Este README documenta los pasos necesarios para levantar la infraestructura del proyecto de ecommerce usando Terraform dentro de un laboratorio de AWS Academy.

---

## 🔀 1. Iniciar el Lab

Link a [AWS Academy Learner Lab](https://www.awsacademy.com/), darle a  **“Start Lab”**.

---

## 🧰 2. Instalar Terraform

Desde la terminal del lab:

```bash
wget https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip
unzip terraform_1.7.5_linux_amd64.zip
```

---

## 📦 3. Mover el binario de Terraform al PATH

```bash
mkdir -p ~/.local/bin
mv terraform ~/.local/bin/
export PATH=$PATH:$HOME/.local/bin
```

Verificar:

```bash
terraform -version
```

---

## 🔐 4. Exportar variables de sesión AWS

Exportar completando con AWS details:

```bash
export AWS_ACCESS_KEY_ID="TU_ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="TU_SECRET_KEY"
export AWS_SESSION_TOKEN="TU_SESSION_TOKEN"
export AWS_DEFAULT_REGION="us-east-1"
```

> **Nota:** No se puede usar `aws configure`, porque no se tiene permisos de escritura en el path por defecto.

---

## 🔑 5. Generar token de acceso en GitHub (una sola vez)

1. Ir a [https://github.com/settings/tokens](https://github.com/settings/tokens)
2. Crear un **Personal Access Token (classic)**
3. Marcar scopes: `repo`, `workflow` y `Read:org`
4. Usar ese token como contraseña al clonar repos privados

---

## 🧬 6. Clonar el repositorio

```bash
git clone https://github.com/FF3R/Infra-ARQ-Solutions.git
```


---

## ⬇️ 7. Hacer `git pull`

```bash
cd Infra-ARQ-Solutions
git pull
```

---

## ⚙️ 8. Ejecutar `terraform init`

```bash
terraform init
```

---

## 🔎 9. Ejecutar `terraform plan`

```bash
terraform plan -var-file="environments/dev/terraform.tfvars"
```

---

## 🚀 10. Ejecutar `terraform apply`

```bash
terraform apply -var-file="environments/dev/terraform.tfvars"
```

Cuando pregunte:

```
Enter a value: yes
```

---

## ✅ Infraestructura de Ecommerce desplegada

Ya está todo listo. Tu plataforma de ecommerce está desplegada y lista para recibir pedidos.

---

Fin ✨
