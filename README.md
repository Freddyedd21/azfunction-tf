# Crear una Máquina Virtual en Azure con Terraform

Este proyecto muestra cómo desplegar una máquina virtual Linux en Azure usando Terraform.

## Pasos realizados

1. **Configuración de archivos Terraform**
   - Se definieron los recursos en `main.tf`:
     - Grupo de recursos
     - Red virtual y subred
     - IP pública
     - Interfaz de red
     - Seguridad de red
     - Máquina virtual Linux

2. **Variables y salidas**
   - Se usó `variables.tf` para definir variables como el nombre de la VM.
   - Se configuró `outputs.tf` para mostrar la IP pública de la VM.

3. **Inicialización y despliegue**
   - Ejecuta:
     ```powershell
     terraform init
     terraform plan
     terraform apply
     ```
   - Ingresa el nombre de la función/VM cuando se solicite.

4. **Conexión a la VM**
   - Obtén la IP pública desde la salida de Terraform o con:
     ```powershell
     terraform output vm_public_ip
     ```
   - Conéctate por SSH:
     ```bash
     ssh freddyedd21@<IP_PUBLICA>
     ```
     Usa la contraseña definida en `main.tf`.

## Dónde mostrar capturas

- **Captura 1:** Salida exitosa de `terraform apply` mostrando la creación de recursos.
![alt text](image.png)

![alt text](image-1.png)

- **Captura 2:** Conexión exitosa por SSH a la VM desde PowerShell o terminal.

![alt text](image-2.png)

- **Captura 3:** Portal de Azure mostrando la VM creada.

![alt text](image-3.png)




