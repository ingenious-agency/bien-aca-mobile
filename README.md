![](images/bienaca-logo-horizontal-negro220.png)

###  Actuar bien, hoy y rápido
Desarrollamos **Bien Acá**, una solución Open Source gratuita compuesta de herramientas fundamentales, expandibles y totalmente customizables, para que puedas ocuparte de lo más importante: seguir salvando vidas en tu país.

El sistema funciona con un único y simple centro de control que recibe alertas sobre los dispositivos vinculados y así puede centrar sus esfuerzos en aquellas incidencias que lo requieran, activando llamadas, protocolos e inspecciones solamente en casos estrictamente necesarios, potenciando sus capacidades y la gestión de los recursos.

## Control de cuarentena obligatoria 🧐
Controlar una cuarentena obligatoria se vuelve cada vez más complejo a medida que el número de casos requeridos aumenta. Existen soluciones en el mercado basadas en rastreo móvil que notifican al centro de control si el dispositivo sale de una zona determinada, aunque no aseguran que el individuo se encuentre efectivamente junto a dicho dispositivo.

Nuestra solución utiliza el análisis biométrico para certificar y asegurar que es el sujeto quien no deja dicha zona y se encuentra con el dispositivo registrado.

### Cómo funciona
1. Se instala en el móvil de la persona a seguir una aplicación que envía información de geolocalización al sistema central.
2. De perderse contacto con el dispositivo (estado sin conectividad o apagado) o el dispositivo salga de la zona establecida, una primer alerta a modo de preaviso se genera para la persona. // *feature a implementar*
3. De no regresar a la zona establecida dentro del tiempo elegido por el prestador, una alerta es enviada: primero al usuario y luego al al centro de control.
4. Adicionalmente y varias veces al día de forma randómica, la aplicación pide al usuario certifique su identidad mediante sensor biométrico, en este caso, huella dactilar.
5. De no verificar identidad, se envía una alerta al centro de control.
 
*El sistema ha sido diseñado para desalentar las acciones no deseadas y minimizar el trabajo de los centros de control: cada vez que una alerta es enviada, es el usuario mismo quien recibe una notificación a modo de aviso previo en su dispositivo, ahorrando tiempo, esfuerzo y dinero a los prestadores.*

### Qué tenemos implementado Mobile
- Registración de usuario
- Servicio de Geofencing
- Heartbeat de reporte continuo
- Test biométrico
- Notificaciones

### Qué tenemos implementado Backend
- Registro y Login de usuario
- Sistema de Heartbeat
- Interface para admins

### Qué faltaría implementar
- Preaviso al usuario
- Randomización de prueba biométrica

## Control y calma en tiempos de crisis 😌
Creemos en **BienAcá** como una solución integral, de implementación rápida pero ampliamente flexible a las necesidades de un contexto en crisis. Fue diseñada para proveer tranquilidad y acierto en momentos extremos. Pensada para cuidar tiempo y dinero; creada para actuar hoy y estar tranquilos mañana.

**Coordinación entre equipos** | En tiempos de crisis la coordinación es fundamental y esta aplicación puede centralizar y simplificar alarmas y eventos.

**Manejo de recursos médicos** | Supervisar recursos tales como salas, equipamientos de alto costo y otros materiales para mantener un traqueo a tiempo real de los mismos.

**Información sobre posible interacción con caso confirmado** | La cuarentena voluntaria requiere de motivación por parte de la población. La aplicación puede ser modificada para notificar a la población que ha tenido contacto (mediante georeferenciación) con un caso conocido.

**Gestión y verificación de Permisos de salida** | Una vez que un individuo es inmune a la enfermedad y es seguro que retorne al trabajo, se le adjudica un certificado digital vinculado a la prueba clínica que lo habilita a volver a circular libremente.

**Luego de la crisis sanitaria puede ser utilizada para medidas cautelares de bajo riesgo** como la prohibición de asistir determinadas reuniones, recintos o espectáculos públicos, o de visitar determinados lugares o de aproximarse a ciertas personas.

# Actuemos juntos!

![](images/ingenious-logo-horizontal-color120.png)
