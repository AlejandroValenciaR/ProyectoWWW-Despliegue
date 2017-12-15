# -*- coding: utf-8 -*-
from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone
from django.core.files.storage import FileSystemStorage


# Create your models here.

fs  = FileSystemStorage(location='eventos/static/eventos/dist/img/imgevents/')
fs2 = FileSystemStorage(location='eventos/static/eventos/dist/img/imgnews/')

class Perfiles(models.Model):
    usuario = models.OneToOneField(User)
    cedula = models.BigIntegerField()
    nombre = models.CharField(max_length=100)
    celular = models.BigIntegerField()
    telefono = models.BigIntegerField()
    email = models.EmailField()
    direccion = models.CharField(max_length=200)
    pais = models.CharField(max_length=200)
    ciudad = models.CharField(max_length=200)
    sexo = models.CharField(max_length=2, default="N")
    tipo = models.CharField(max_length=30)
    session = models.CharField(max_length=1, default="0")
    estado = models.CharField(max_length=10, default="ACTIVO")

    def __unicode__(self):
        return self.usuario.username

class Evento(models.Model):
    nombre = models.CharField(max_length=200)
    valor_inscripcion = models.BigIntegerField(default=0)
    fecha_creacion = models.DateTimeField(default=timezone.now)
    fecha_inicio = models.DateField()
    fecha_fin = models.DateField()
    estado = models.BooleanField()
    ubicacion = models.CharField(max_length=200)
    banner = models.ImageField(storage=fs, default = 'static/eventos/dist/img/avatar.png')
    descripcion = models.CharField(max_length=10000, default='No hay descripcion')

    def __str__(self):
        return '%s' % self.nombre

class Actividad(models.Model):
    nombre = models.CharField(max_length=200)
    descripcion = models.CharField(max_length=5000)
    evento = models.ForeignKey(Evento, limit_choices_to={'estado': True})
    estado = models.CharField(max_length=10,default='ACTIVA')
    fecha_creacion = models.DateTimeField(default=timezone.now)
    dia_actividad = models.IntegerField(default=1)
    hora_inicio = models.TimeField()
    hora_fin = models.TimeField()

    def __str__(self):
        return self.nombre

class Noticia(models.Model):
    nombre = models.CharField(max_length=200)
    fecha_creacion = models.DateTimeField(default=timezone.now)
    fecha_publicacion = models.DateField()
    autor = models.ForeignKey(User)
    contenido = models.TextField()
    banner = models.ImageField(storage=fs2, default = 'static/eventos/dist/img/avatar.png')
    evento = models.ForeignKey(Evento, limit_choices_to={'estado': True})
    estado = models.BooleanField()

    def __str__(self):
        return self.nombre

class Inscripcion(models.Model):
    inscrito = models.BigIntegerField()
    nombre_inscrito = models.CharField(max_length=50, default="N/A")
    direccion_inscrito = models.CharField(default="Sin Direccion", max_length=100)
    telefono = models.BigIntegerField(default=0)
    celular = models.BigIntegerField(default=0)
    evento = models.ForeignKey(Evento, limit_choices_to={'estado': True})
    pais = models.CharField(default="NA", max_length=10)
    sexo = models.CharField(default="N", max_length=10)
    correo = models.EmailField(default="Sin email");
    fecha_inscripcion = models.DateTimeField(default=timezone.now)
    estado = models.CharField(max_length=50)

    def confirmar_pago(self, request):
        import requests
        from django.contrib import messages
        from django.conf import settings

        url_web_service = 'http://127.0.0.1:8000/pago/consulta'

        datos = { 'id' : self.id }

        respuesta = requests.get(url_web_service, params=datos, verify=False)

        if respuesta.status_code == requests.codes.ok:
            estado_pago = respuesta.json()['estado_pago']
            if estado_pago == "PAGADO":
                self.estado = 'INSCRITO'
                self.save()
                return True
            else:
                return False
        else:
            return False

class Inscripcion_operador(models.Model):
    inscripcion = models.ForeignKey(Inscripcion, limit_choices_to={'estado': True})
    operador = models.ForeignKey(User)
    fecha_validacion = models.DateTimeField(default=timezone.now)