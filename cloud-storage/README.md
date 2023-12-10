### Cloud-Storage
Crearemos un Bucket y usaremos algunos comandos para eliminar crear, eliminar y publicar un bucket,
#### Entraremos a la consola de GCP y a cloud shell o debe estar autenticando en su terminal de GCP.
```Bash
gcloud auth list 
```
dentro de la consola de Clud Shell podemos hacer un update.
```Bash
sudo apt update 
sudo apt upgrade -y 
```
clonaremos el repositorio de prueba para los datos que usaremos, puede usar cualquier otro repositorio.

```Bash
git clone -b master  https://github.com/nilofe/smp.git
```
pasaremos algunas variables de entorno, es opcional.
```Bash
PROJECT_ID=$(gcloud config get-value project)
BUCKET=${PROJECT_ID}-nombrebucket
```
Crearemos un bucket de clase multiregional.
```Bash
gsutil mb -c multi_regional gs://${BUCKET}
```
Subiremos nuestra carpeta clonada a nuestro bucket.
```Bash
gsutil -m cp -r smp gs://${BUCKET}
```
Listaremos nuestro archivos de nuestro bucket.
```Bash
gsutil ls gs://${BUCKET}/*
```




