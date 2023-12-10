### Cloud-Storage
Crearemos un Bucket y usaremos algunos comandos para eliminar crear, eliminar y publicar un bucket,
clonaremos el repositorio de prueba para los datos que usaremos, puede usar cualquier otro repositorio.
```Bash
git clone -b master  https://github.com/nilofe/smp.git
```
pasaremos algunas variables de entorno.


```Bash
PROJECT_ID=$(gcloud config get-value project)
BUCKET=${PROJECT_ID}-nombrebucket
```

