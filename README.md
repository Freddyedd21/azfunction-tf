## informe para subir una funcion con terraform a azure
## estudiante: Samuel Alvarez Alban A00394750

1) logearse en azure CLI con el comando az login

![alt text](image.png)

2) ver el id de la subcripcion del usuario de azure y remplazarlo en el main

![alt text](image-1.png)

![alt text](image-2.png)

3) listo ahora ya procedemos a subir nuestra primera funcion

terraform init: Inicializa el proyecto Terraform y descarga los proveedores necesarios.

![alt text](image-3.png)

terraform validate: Verifica que la configuración de Terraform sea válida.

terraform fmt: Formatea el código Terraform siguiendo las convenciones estándar

![alt text](image-4.png)

terraform plan: Muestra los cambios que Terraform realizará en la infraestructura.

![alt text](image-5.png)

![alt text](image-6.png)

terraform apply: Aplica los cambios y crea/modifica la infraestructura según la configuración.

![alt text](image-7.png)

![alt text](image-8.png)

este es el link que arroja despues de hacer apply

![alt text](image-9.png)

y aqui se encuentra la function en el grupo de recursos

![alt text](image-10.png)

la funcion es alvarezfirstfunction.

aqui una prueba

![alt text](image-11.png)
